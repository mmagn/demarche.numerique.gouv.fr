# frozen_string_literal: true

describe WebhookController, type: :controller do
  describe '#crisp' do
    let(:payload) do
      {
        "event" => "message:send",
        "data" => {
          "from" => "user",
          "user" => { "user_id" => "default_user@user.com" },
        },
      }
    end

    let(:body) { payload }
    let(:timestamp) { Time.current }

    before do
      stub_const('ENV', ENV.to_hash.merge('CRISP_WEBHOOK_SECRET' => 'testsecret'))
    end

    it 'processes the webhook when signature is valid' do
      expected_signature = OpenSSL::HMAC.hexdigest('sha256',
        'testsecret',
        "[#{timestamp};#{body.to_json}]")

      expect(Crisp::WebhookProcessor).to receive(:new).and_call_original

      request.headers.merge!({
        'X-Crisp-Request-Timestamp' => timestamp,
        'X-Crisp-Signature' => expected_signature,
      })

      post :crisp, params: body, as: :json
      expect(response).to have_http_status(:ok)
    end

    it "doesn't process the webhook when signature is invalid" do
      expect(Crisp::WebhookProcessor).not_to receive(:new)

      request.headers.merge!({
        'X-Crisp-Request-Timestamp' => timestamp,
        'X-Crisp-Signature' => 'bad_signature',
      })

      post :crisp, params: body, as: :json
      expect(response).not_to have_http_status(:ok)
    end
  end
end
