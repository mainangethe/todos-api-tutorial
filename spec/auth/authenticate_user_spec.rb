require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  # valid request subject
  subject(:valid_authentication_object) { described_class.new(user.email, user.password) }

  # invalid request subject
  subject(:invalid_authentication_object) { described_class.new('guess', 'work') }

  describe '#call' do
    context 'with valid credentials' do
      
      it 'returns an authentication token' do
        token = valid_authentication_object.call
        expect(token).not_to be_nil
      end

    end

    context 'with invalid credentials' do
      
      it 'returns "authentication" error' do
        expect { invalid_authentication_object.call }
          .to raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
      end
      
    end

  end

end