# frozen_string_literal: true

RSpec.describe BddOpenai::Client::HttpClient do
  subject(:client) { described_class.new }

  describe '#call_get' do
    context 'when successfully call a GET API' do
      subject(:response) do
        VCR.use_cassette('sample_api_get') do
          uri = URI.parse('https://reqres.in/api/users/2')
          headers = { "Content-Type": 'application/json' }
          client.call_get(uri, headers)
        end
      end

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

  describe '#call_post' do
    context 'when successfully call a POST API' do
      subject(:response) do
        VCR.use_cassette('sample_api_post') do
          uri = URI.parse('https://reqres.in/api/users')
          headers = { "Content-Type": 'application/json' }
          body = {
            "name": 'morpheus',
            "job": 'leader'
          }.to_json
          client.call_post(uri, body, headers)
        end
      end

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

  describe '#call_delete' do
    context 'when successfully call a DELETE API' do
      subject(:response) do
        VCR.use_cassette('sample_api_delete') do
          uri = URI.parse('https://reqres.in/api/users/2')
          headers = { "Content-Type": 'application/json' }
          client.call_delete(uri, headers)
        end
      end

      it 'returns HTTP code 204' do
        expect(response.code).to eq('204')
      end

      it 'returns expected response body' do
        expect(response.body).to be_nil
      end
    end
  end
end
