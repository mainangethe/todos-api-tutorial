require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }

  # Mock `Authorization` header
  let(:header) { { 'Authorization' => token_generator(user.id) } }

  # valid request subject
  subject(:request_object) { described_class.new(header) }
  # invalid request subject
  subject(:invalid_request_object) { described_class.new({}) }

  describe '#call' do
    # returns the user object when the request is valid
    context 'when request is valid' do
      it 'returns user object' do
        result = request_object.call
        expect(result[:user]).to eq user
      end
    end

    context 'when request is invalid' do
      it 'raises a "Missing Token" error' do
        expect { invalid_request_object.call }
          .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
      end
    end

    context 'when token is invalid' do
      subject(:invalid_request_object) do
        described_class.new('Authorization' => token_generator(5))
      end

      it 'raises an "InvalidToken" error' do
        expect { invalid_request_object.call }
          .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
      end
    end

    context 'when the token has expired' do
      let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
      subject(:request_object) { described_class.new(header) }

      it 'raises "Expired Signature" error' do
        expect { request_object.call }
          .to raise_error(
            ExceptionHandler::InvalidToken, /Signature has expired/)
      end
    end

    context 'when the token is fake' do
      let(:header) { { 'Authorization' => 'foobar' } }
      subject(:invalid_request_object) { described_class.new(header) }
      
      it 'raises "Invalid Token" error' do
        expect { invalid_request_object.call }
          .to raise_error(
            ExceptionHandler::InvalidToken, /Not enough or too many segments/)
      end
    end

  end

end