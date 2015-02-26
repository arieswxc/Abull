ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :nick_name, :real_name, :avatar, :cell

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
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :nick_name
  filter :real_name
  filter :cell
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :avatar
      f.input :email
      f.input :nick_name
      f.input :real_name
      f.input :cell
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
