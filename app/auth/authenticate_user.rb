class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  # service entry point
  def call
    if verify_user
      user = verify_user
      JsonWebToken.encode(user_id: user.id)
    end
  end

  private

  attr_reader :email, :password
  
  # verify user credentials

  def verify_user
    user = User.find_by(email: email)
    return user if user && user.authenticate(password)
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end

end