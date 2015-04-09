class PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  def new
    self.resource = resource_class.new
  end
end

