# frozen_string_literal: true

RSpec.describe BddOpenai::Client::HttpClient do
  describe '#call_get' do
    context 'when successfully call a GET API' do
      VCR.use_cassette('sample_api_get') do
        client = described_class.new
        uri = URI.parse('https://reqres.in/api/users/2')
        headers = { "Content-Type": 'application/json' }
        response = client.call_get(uri, headers)

        it 'returns HTTP code 200' do
          expect(response.code).to eq('200')
        end

        it 'returns expected response body' do
          expected_response = {
            "data": {
              "id": 2,
              "email": 'janet.weaver@reqres.in',
              "first_name": 'Janet',
              "last_name": 'Weaver',
              "avatar": 'https://reqres.in/img/faces/2-image.jpg'
            },
            "support": {
              "url": 'https://reqres.in/#support-heading',
              "text": 'To keep ReqRes free, contributions towards server costs are appreciated!'
            }
          }.to_json
          expect(response.body).to eq(expected_response)
        end
      end
    end
  end
end
