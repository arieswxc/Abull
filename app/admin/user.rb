include ApplicationHelper
ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :nick_name, :real_name, :avatar, :cell, :id_card_number, :abstract, :level,
                :birthday, :gender, :education, :address, :job, photos_attributes: [:title, :photo]
 
  index do
    selectable_column
    id_column
    column :avatar do |user|
      image_tag user.avatar.thumb.url
    end
    column :email
    column :nick_name
    column :real_name
    column :cell
    column :id_card_number
    column :abstract
    column :level
    column :birthday
    column :gender
    column :education
    column :address
    column :job
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  # filter :email
  # filter :nick_name
  # filter :real_name
  # filter :cell
  # filter :id_card_number
  # filter :abstract
  filter :level
  # filter :current_sign_in_at
  # filter :sign_in_count
  # filter :created_at

  show do |user|
    attributes_table do
      row :email
      row :nick_name
      row :real_name
      row :cell
      row :id_card_number
      row :abstract
      row :level
      row('升级')  do 
          link_to t('Upgrade'), upgrade_user_admin_user_path(user), :method => :put, :class => 'button' 
      end  if check_user(current_admin_user)
      row('降级')  do 
          link_to t('Degrade'), degrade_user_admin_user_path(user), :method => :put, :class => 'button' 
      end  if check_user(current_admin_user)
      row :current_sign_in_at
      row :sign_in_count
      row :created_at
    end

    panel t('用户身份信息') do 
      attributes_table_for user do
        row :real_name
        row :id_card_number
        row :birthday
        row :education
        row :gender
        row :address
        row :job
        user.photos.each do |p|
          row("#{p.title}") { link_to image_tag(p.photo, width:400, height:400), p.photo.url }    
          # row("#{p.title}") { link_to image_tag(p.photo.thumb), p.photo.url }        
        end
      end
    end
  end


  #侧边窗口
  sidebar "User List", only: :show do
    table_for User.all do
      column :email do |u|
        link_to u.email, admin_user_path(u)
      end
      column :real_name
      column :level
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :avatar
      f.input :email
      f.input :nick_name
      f.input :real_name
      f.input :cell
      f.input :id_card_number
      f.input :abstract
      f.input :level
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  member_action :upgrade_user, :method => :put do
    user = User.find(params[:id])
    if user.level == 'investor_applied'
      user.up_to_inv
    elsif user.level == 'trader_applied'
      user.up_to_td
    end
    redirect_to admin_user_path(user)
  end

  member_action :degrade_user, :method => :put do
    user = User.find(params[:id])
    if user.level == 'trader'
      user.down_to_inv
    elsif user.level == 'investor'
      user.down_to_un
    end
    redirect_to admin_user_path(user)
  end

end
