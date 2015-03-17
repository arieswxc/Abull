class RegistrationsController < Devise::RegistrationsController
  after_filter :add_account

  protected
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def add_account
      if resource.persisted?
        resource.create_account
      end
    end
end
