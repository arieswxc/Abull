class RegistrationsController < Devise::RegistrationsController
  after_filter :add_account
  after_filter :add_three_photos
  protected
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def add_account
      if resource.persisted?
        resource.create_account if resource.account.nil?
      end
    end

    def add_three_photos
      if resource.persisted?
        resource.photos.create(title: "身份证正面")
        resource.photos.create(title: "身份证反面")
        resource.photos.create(title: "手持身份证露脸照片")
      end
    end
end
