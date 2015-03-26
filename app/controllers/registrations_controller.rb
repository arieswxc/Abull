class RegistrationsController < Devise::RegistrationsController
  # after_filter :add_account, only: [:update_resource]
  # after_filter :add_three_photos, only: [:update_resource]
  after_filter :add_account
  after_filter :add_three_photos

  def create
    if session[:code] != params[:verification_code].to_i
      flash[:notice] = "验证码错误"
      redirect_to new_registration_path(resource_name)
    elsif User.find_by(user_name: params[:user_name])
      flash[:notice] = "用户昵称已经被注册，请更换"
      redirect_to new_registration_path(resource_name)
    else
      build_resource(sign_up_params)
  
      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message :notice, :signed_up if is_flashing_format?
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end      
  end

  protected
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def add_account
      if resource.account.nil?
        resource.create_account
      end
    end

    def add_three_photos
      if resource.persisted?
        resource.photos.create(title: "身份证正面")
        resource.photos.create(title: "身份证反面")
        resource.photos.create(title: "手持身份证露脸照片")
      end
    end

    def set_minimum_password_length
      if devise_mapping.validatable?
        @minimum_password_length = resource_class.password_length.min
      end
    end


end
