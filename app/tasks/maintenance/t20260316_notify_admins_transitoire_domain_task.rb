# frozen_string_literal: true

module Maintenance
  class T20260316NotifyAdminsTransitoireDomainTask < MaintenanceTasks::Task
    # Envoie un email aux administrateurs dont les démarches reçoivent du trafic
    # sur le domaine demarches.numerique.gouv.fr (avec un "s") pour leur demander
    # de mettre à jour leurs liens avant la suppression de ce domaine.
    #
    # CSV attendu avec une colonne "url" contenant des URLs ou paths /commencer/xxx

    include ActionView::Helpers::SanitizeHelper
    include Rails.application.routes.url_helpers

    default_url_options[:host] = APPLICATION_BASE_URL
    default_url_options[:protocol] = :https
    csv_collection

    def process(row)
      path = row["url"].strip.match(%r{commencer/([^?\s]+)}).captures.first
      procedure = Procedure.find_with_path(path).first!
      emails = procedure.administrateurs.map { it.user.email }

      BlankMailer.send_template(to: emails, subject:, title:, body: email_body(procedure, path)).deliver_later
    end

    private

    def subject = "[#{APPLICATION_NAME}] Action requise : mise à jour de votre lien de démarche"
    def title = "Mise à jour de vos liens"

    def email_body(procedure, path)
      correct_url = commencer_url(procedure.path)
      old_url = "https://demarches.numerique.gouv.fr/commencer/#{path}"

      # rubocop:disable DS/ApplicationName
      <<~HTML
        <p>
          Bonjour,<br><br>

          Vous recevez ce message car le formulaire de votre démarche <strong>#{sanitize(procedure.libelle)}</strong>
          est encore fréquemment accédé via l’adresse
          <strong>demarches.numerique.gouv.fr</strong> (avec un «\u00A0s\u00A0») à la place de
          <strong>demarche.numerique.gouv.fr</strong> (sans «\u00A0s\u00A0»).
        </p>

        <p>
          Cette adresse sera <strong>supprimée dans les prochaines semaines</strong>
          et les liens l’utilisant ne fonctionneront plus.
        </p>

        <p>
          Au vu du trafic reçu et de son référencement sur les moteurs de recherche,
          il est probable que vous ayez publié ou partagé le lien suivant\u00A0:<br>
          <code>#{url_without_link(old_url)}</code>
        </p>

        <p>
          Si c’est le cas, <strong>merci de le remplacer par</strong>\u00A0:<br>
          <a href="#{correct_url}"><code>#{correct_url}</code></a>
        </p>

        <p>
          Pensez à vérifier vos sites web, documents, emails et tout autre support
          où ce lien pourrait apparaître.
        </p>

        <p>
          Pour information, nous n’avons pas encore de date précise pour cette suppression,
          cela dépendra du trafic encore reçu.
        </p>

        <p>
          Nous restons à votre disposition pour toute question sur #{CONTACT_EMAIL}.
        </p>
      HTML
      # rubocop:enable DS/ApplicationName
    end

    def url_without_link(url)
      url.gsub(".", "&#8288;.")
    end
  end
end
