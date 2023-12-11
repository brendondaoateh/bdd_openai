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

  describe '#call_post' do
    context 'when successfully call a POST API' do
      VCR.use_cassette('sample_api_post') do
        client = described_class.new
        uri = URI.parse('https://reqres.in/api/users')
        headers = { "Content-Type": 'application/json' }
        body = {
          "name": 'morpheus',
          "job": 'leader'
        }.to_json
        response = client.call_post(uri, body, headers)

        it 'returns HTTP code 201' do
          expect(response.code).to eq('201')
        end

        it 'returns expected response body' do
          expected_response = {
            "name": 'morpheus',
            "job": 'leader',
            "id": '198',
            "createdAt": '2023-12-11T02:09:53.153Z'
          }.to_json
          expect(response.body).to eq(expected_response)
        end
      end
    end
  end
end
