# frozen_string_literal: true

describe 'As an administrateur I can use Simpliscore to improve my procedure', js: true do
  let(:administrateur) { procedure.administrateurs.first }
  let(:procedure) { create(:procedure, types_de_champ_public: [{ type: :text, libelle: 'NOM' }]) }
  let(:rule) { 'improve_label' }

  before do
    Flipper.enable(:llm_nightly_improve_procedure, procedure)
    login_as administrateur.user, scope: :user
  end

  describe 'complete workflow through all 4 steps' do
    scenario 'navigating through all steps with auto-enchainement' do
      # Step 1: improve_label - use new_simplify entry point
      visit new_simplify_admin_procedure_types_de_champ_path(procedure)

      # Extract tunnel_id from URL
      expect(page).to have_current_path(/simplify\/([a-f0-9]{6})\/improve_label/)
      tunnel_id = current_path.match(/simplify\/([a-f0-9]{6})\//)[1]

      expect(page).to have_content("Libellés et descriptions des champs")
      expect(page).to have_button("Lancer la recherche de suggestions")

      # Launch the search
      click_button "Lancer la recherche de suggestions"
      expect(page).to have_content("Recherche en cours")

      # Simulate completion by updating existing suggestion (created by new_simplify)
      llm_rule_suggestion = procedure.draft_revision.llm_rule_suggestions.find_by!(tunnel_id:, rule: 'improve_label')
      llm_rule_suggestion.update!(state: 'completed')

      create(:llm_rule_suggestion_item,
        llm_rule_suggestion: llm_rule_suggestion,
        stable_id: procedure.draft_revision.revision_types_de_champ_public.first.stable_id,
        payload: { 'stable_id' => procedure.draft_revision.revision_types_de_champ_public.first.stable_id, 'libelle' => 'Nom' })

      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_label')

      expect(page).to have_content(/1\s+suggestion/)
      expect(page).to have_css("input[type='submit'][disabled]")
      expect(page).to have_button("Ignorer cette étape et poursuivre")

      # Verify stepper is shown and has correct text
      expect(page).to have_css('.fr-stepper')
      expect(page).to have_content("Étape suivante")

      # Accept the suggestion by checking the checkbox
      first('input[type="checkbox"][name*="verify_status"]').check(allow_label_click: true)

      expect(page).not_to have_css("input[type='submit'][disabled]")

      click_button "Appliquer les suggestions et poursuivre"

      # Auto-enchainement: Step 2 was created and search launched automatically
      expect(page).to have_current_path(simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_structure'))
      expect(page).to have_content("Structure du formulaire")

      # Verify that step 2 suggestion exists (created by auto-enchainement)
      expect(procedure.draft_revision.llm_rule_suggestions.find_by(tunnel_id:, rule: 'improve_structure')).to be_present

      # Step 2: improve_structure - simulate completion (no suggestions)
      llm_rule_suggestion_2 = procedure.draft_revision.llm_rule_suggestions.find_by!(tunnel_id:, rule: 'improve_structure')
      llm_rule_suggestion_2.update!(state: 'completed')

      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_structure')

      # No suggestions - skip this step
      expect(page).to have_button("Poursuivre")
      click_button "Poursuivre"

      # Auto-enchainement: Step 3 was created and search launched automatically
      expect(page).to have_current_path(simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_types'))
      expect(page).to have_content("Bonne utilisation des types de champs")

      # Step 3: improve_types - simulate completion (no suggestions)
      llm_rule_suggestion_3 = procedure.draft_revision.llm_rule_suggestions.find_by!(tunnel_id:, rule: 'improve_types')
      llm_rule_suggestion_3.update!(state: 'completed')

      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_types')

      # No suggestions - skip this step
      expect(page).to have_button("Poursuivre")
      click_button "Poursuivre"

      # Auto-enchainement: Step 4 (last step) was created and search launched automatically
      expect(page).to have_current_path(simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'cleaner'))
      expect(page).to have_content(/demande unique d’information/i)

      # Step 4: cleaner - simulate completion (no suggestions)
      llm_rule_suggestion_4 = procedure.draft_revision.llm_rule_suggestions.find_by!(tunnel_id:, rule: 'cleaner')
      llm_rule_suggestion_4.update!(state: 'completed')

      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'cleaner')

      # Should show success message (no suggestions)
      expect(page).to have_content(/Félicitations/)
      expect(page).to have_button("Poursuivre")

      # Verify stepper is still shown (not finished until we click Poursuivre)
      expect(page).to have_css('.fr-stepper')

      # Click Poursuivre to finish the tunnel
      click_button "Poursuivre"

      # After finishing the last step, we stay on cleaner to show the end-of-tunnel message
      expect(page).to have_current_path(simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'cleaner'))

      # Should see the end-of-tunnel message
      expect(page).to have_content("Ce parcours d’amélioration de la qualité du formulaire est terminé.")
    end
  end
  describe 'error handling' do
    scenario 'shows error message and retry button when search fails' do
      tunnel_id = SecureRandom.hex(3)
      llm_rule_suggestion = create(:llm_rule_suggestion,
        procedure_revision: procedure.draft_revision,
        tunnel_id:,
        rule: 'improve_label',
        state: 'failed',
        schema_hash: Digest::SHA256.hexdigest(procedure.draft_revision.schema_to_llm.to_json))

      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_label')

      expect(page).to have_content("La recherche de suggestions a échoué, veuillez réessayer.")
      expect(page).to have_button("Relancer la recherche de suggestions")
    end
  end

  describe 'schema change detection' do
    scenario 'allows regenerating suggestions when schema has changed' do
      tunnel_id = SecureRandom.hex(3)

      # Create initial suggestion with current schema
      initial_schema_hash = Digest::SHA256.hexdigest(procedure.draft_revision.schema_to_llm.to_json)
      llm_rule_suggestion = create(:llm_rule_suggestion,
        procedure_revision: procedure.draft_revision,
        tunnel_id:,
        rule: 'improve_label',
        state: 'completed',
        schema_hash: initial_schema_hash)

      # Add suggestion items to the initial suggestion
      create(:llm_rule_suggestion_item,
        llm_rule_suggestion: llm_rule_suggestion,
        stable_id: procedure.draft_revision.revision_types_de_champ_public.first.stable_id,
        payload: { 'stable_id' => procedure.draft_revision.revision_types_de_champ_public.first.stable_id, 'libelle' => 'Nouveau libellé' })

      # Change the schema by adding a new field
      procedure.draft_revision.add_type_de_champ(
        type_champ: :text,
        libelle: 'Nouveau champ ajouté'
      )
      new_schema_hash = Digest::SHA256.hexdigest(procedure.draft_revision.reload.schema_to_llm.to_json)

      # Verify schema has actually changed
      expect(new_schema_hash).not_to eq(initial_schema_hash)

      # Visit the same step
      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_label')

      # Should NOT show the old completed suggestion
      # Instead, should show the button to launch a new search
      expect(page).to have_button("Lancer la recherche de suggestions")
      expect(page).not_to have_css('.fr-badge', text: /\d+ suggestions?/) # No suggestion count badge
      expect(page).not_to have_button("Appliquer les suggestions et poursuivre") # No apply button

      # Click to launch new search
      click_button "Lancer la recherche de suggestions"

      # Should show success message
      expect(page).to have_content("La recherche a été lancée")

      # The click created a suggestion in 'queued' state with the new schema_hash
      # Find it and simulate completion
      new_suggestion = LLMRuleSuggestion.find_by!(
        procedure_revision: procedure.draft_revision,
        tunnel_id: tunnel_id,
        rule: 'improve_label',
        schema_hash: new_schema_hash
      )

      expect(new_suggestion.state).to eq('queued')

      # Simulate completion
      new_suggestion.update!(state: 'completed')
      create(:llm_rule_suggestion_item,
        llm_rule_suggestion: new_suggestion,
        stable_id: procedure.draft_revision.revision_types_de_champ_public.last.stable_id,
        payload: { 'stable_id' => procedure.draft_revision.revision_types_de_champ_public.last.stable_id, 'libelle' => 'Libellé pour nouveau champ' })

      # Visit the page again to see the new suggestion
      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_label')

      # Should now show the new suggestion with the new schema
      expect(page).to have_css('.fr-badge', text: /1\s+suggestion/)
      expect(page).to have_css("input[type='submit'][value='Appliquer les suggestions et poursuivre']")

      # Verify both suggestions exist in database
      expect(LLMRuleSuggestion.where(tunnel_id: tunnel_id, rule: 'improve_label').count).to eq(2)

      # Old suggestion with old schema_hash
      old_suggestion = LLMRuleSuggestion.find(llm_rule_suggestion.id)
      expect(old_suggestion.schema_hash).to eq(initial_schema_hash)
      expect(old_suggestion.state).to eq('completed')

      # New suggestion with new schema_hash
      expect(new_suggestion.schema_hash).to eq(new_schema_hash)
      expect(new_suggestion.state).to eq('completed')
      expect(new_suggestion.id).not_to eq(llm_rule_suggestion.id)
    end
  end

  describe 'typography' do
    scenario 'uses correct French typography with space before exclamation mark' do
      tunnel_id = SecureRandom.hex(3)
      llm_rule_suggestion = create(:llm_rule_suggestion,
        procedure_revision: procedure.draft_revision,
        tunnel_id:,
        rule: 'improve_label',
        state: 'completed',
        schema_hash: Digest::SHA256.hexdigest(procedure.draft_revision.schema_to_llm.to_json))

      visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_label')

      # No suggestions, should show "votre formulaire est déjà de qualité !"
      expect(page).to have_content("qualité !")
    end
  end

  describe 'button wording' do
    context 'when on first 3 steps with suggestions' do
      scenario 'shows "Appliquer les suggestions et poursuivre"' do
        tunnel_id = SecureRandom.hex(3)
        llm_rule_suggestion = create(:llm_rule_suggestion,
          procedure_revision: procedure.draft_revision,
          tunnel_id:,
          rule: 'improve_label',
          state: 'completed',
          schema_hash: Digest::SHA256.hexdigest(procedure.draft_revision.schema_to_llm.to_json))

        create(:llm_rule_suggestion_item,
          llm_rule_suggestion: llm_rule_suggestion,
          stable_id: procedure.draft_revision.revision_types_de_champ_public.first.stable_id,
          payload: { 'stable_id' => procedure.draft_revision.revision_types_de_champ_public.first.stable_id, 'libelle' => 'Nom' })

        visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'improve_label')

        # Accept the suggestion
        first('input[type="checkbox"][name*="verify_status"]').check(allow_label_click: true)

        expect(page).to have_button("Appliquer les suggestions et poursuivre")
        expect(page).to have_button("Ignorer cette étape et poursuivre")
      end
    end

    context 'when on last step with suggestions' do
      scenario 'shows "Appliquer les suggestions et terminer"' do
        # Complete first 3 steps
        tunnel_id = SecureRandom.hex(3)
        create(:llm_rule_suggestion,
          procedure_revision: procedure.draft_revision,
          tunnel_id:,
          rule: 'improve_label',
          state: 'accepted',
          created_at: 2.days.ago,
          schema_hash: Digest::SHA256.hexdigest(procedure.draft_revision.schema_to_llm.to_json))

        llm_rule_suggestion_cleaner = create(:llm_rule_suggestion,
          procedure_revision: procedure.draft_revision,
          tunnel_id:,
          rule: 'cleaner',
          state: 'completed',
          schema_hash: Digest::SHA256.hexdigest(procedure.draft_revision.schema_to_llm.to_json))

        create(:llm_rule_suggestion_item,
          llm_rule_suggestion: llm_rule_suggestion_cleaner,
          stable_id: procedure.draft_revision.revision_types_de_champ_public.first.stable_id,
          payload: { 'stable_id' => procedure.draft_revision.revision_types_de_champ_public.first.stable_id, 'action' => 'delete' })

        visit simplify_admin_procedure_types_de_champ_path(procedure, tunnel_id:, rule: 'cleaner')

        # Accept the suggestion
        first('input[type="checkbox"][name*="verify_status"]').check(allow_label_click: true)

        expect(page).to have_button("Appliquer les suggestions et terminer")
        expect(page).to have_button("Ignorer cette étape et terminer")
      end
    end
  end
end
