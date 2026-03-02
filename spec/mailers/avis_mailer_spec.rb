# frozen_string_literal: true

RSpec.describe AvisMailer, type: :mailer do
  describe ".avis_invitation_and_confirm_email" do
    let(:procedure) { create(:procedure) }
    let(:dossier) { create(:dossier, :en_instruction, procedure: procedure) }
    let(:dossier2) { create(:dossier, :en_instruction, procedure: procedure) }

    let(:user) { create(:user, confirmation_token: "token") }
    let(:expert) { create(:expert, user: user) }
    let(:experts_procedure) { create(:experts_procedure, expert: expert, procedure: procedure) }

    let(:avis1) { create(:avis, dossier: dossier, experts_procedure: experts_procedure) }
    let(:avis2) { create(:avis, dossier: dossier2, experts_procedure: experts_procedure) }

    let(:mail) do
      described_class
        .avis_invitation_and_confirm_email(user, user.confirmation_token, avis_param)
        .deliver_now
    end

    shared_examples "includes targeted link" do
      it "includes a targeted_user_link in email body" do
        mail # force rendering

        link = TargetedUserLink.last
        expect(link).not_to be_nil
        expect(mail.html_part.body.to_s).to include("/targeted_user_links/#{link.id}")
      end
    end

    context "with single avis" do
      let(:avis_param) { avis1 }

      context "when user is active and verified" do
        let(:user) { create(:user, :active, :with_email_verified, confirmation_token: "token") }

        it "does not include confirmation_token" do
          expect(mail.html_part.body.to_s).not_to include("confirmation_token=")
        end

        include_examples "includes targeted link"
      end

      context "when user is inactive" do
        let(:user) { create(:user, :inactive, confirmation_token: "token") }

        it "includes confirmation_token" do
          expect(mail.html_part.body.to_s).to include("confirmation_token=token")
        end

        include_examples "includes targeted link"
      end

      context "when user is active but unverified" do
        let(:user) { create(:user, :active, email_verified_at: nil, confirmation_token: "token") }

        it "includes confirmation_token" do
          expect(mail.html_part.body.to_s).to include("confirmation_token=token")
        end

        include_examples "includes targeted link"
      end
    end

    context "with multiple avis" do
      let(:avis_param) { [avis1, avis2] }

      context "when user is active and verified" do
        let(:user) { create(:user, :active, :with_email_verified, confirmation_token: "token") }

        it "does not include confirmation_token" do
          expect(mail.html_part.body.to_s).not_to include("confirmation_token=")
        end

        include_examples "includes targeted link"
      end

      context "when user is inactive" do
        let(:user) { create(:user, :inactive, confirmation_token: "token") }

        it "includes confirmation_token" do
          expect(mail.html_part.body.to_s).to include("confirmation_token=token")
        end

        include_examples "includes targeted link"
      end

      context "when user is active but unverified" do
        let(:user) { create(:user, :active, email_verified_at: nil, confirmation_token: "token") }

        it "includes confirmation_token" do
          expect(mail.html_part.body.to_s).to include("confirmation_token=token")
        end

        include_examples "includes targeted link"
      end

      context "when all dossiers are hidden" do
        let(:user) { create(:user, :active, :with_email_verified, confirmation_token: "token") }

        before do
          dossier.update!(hidden_by_administration_at: 1.hour.ago)
          dossier2.update!(hidden_by_administration_at: 1.hour.ago)
        end

        it "does not send the email" do
          result = described_class
            .avis_invitation_and_confirm_email(user, user.confirmation_token, avis_param)

          expect(result.message).to be_a(ActionMailer::Base::NullMail)
        end
      end
    end
  end
end
