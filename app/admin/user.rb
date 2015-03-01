ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :nick_name, :real_name, :avatar, :cell, :id_card_number, :abstract, :level

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
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :nick_name
  filter :real_name
  filter :cell
  filter :id_card_number
  filter :abstract
  filter :level
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
      f.input :id_card_number
      f.input :abstract
      f.input :level
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
