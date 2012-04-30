require "user"

class SignInResource < HamlResource
  include Authentication

  def is_authorized?(authorization_header)
    basic_auth(authorization_header) do |username, password|
      @user = User.find(username)
      @signed_in = @user && @user.password == password
    end
    true
  end

  private

  def to_xhtml
    if @signed_in
      view("signed_in").render(@user)
    else
      super
    end
  end
end
