ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :nick_name, :real_name, :avatar, :cell, :id_card_number, :abstract, :level,
                photos_attributes:[ :title, :photo ]

  index do
    selectable_column
    id_column
    column :avatar do |user|
      image_tag user.avatar.thumb.url
    end
    column "电子邮件", :email
    column "昵称", :nick_name
    column "真实姓名", :real_name
    column :cell
    column "身份证号", :id_card_number
    column :abstract
    column "用户等级", :level
    column :current_sign_in_at
    column :sign_in_count
    column "用户创建日期", :created_at
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
      row('电子邮件')  { |u| u.email }
      row('昵称')     { |u| u.nick_name }
      row('真实姓名')  { |u| u.real_name }
      row :cell
      row('身份证号')  { |u| u.id_card_number }
      row :abstract
      row('用户等级')  { |u| u.level }
      row :current_sign_in_at
      row :sign_in_count
      row('用户创建日期') { |u| u.created_at }
    end

    panel t('用户身份信息') do 
      attributes_table_for user do
        row('真实姓名') { |u| u.real_name }
        row('身份证号') { |u| u.id_card_number }
        user.photos.each do |p|
            row("#{p.title}") { image_tag p.photo }
        end
      end
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
      f.inputs do
        f.has_many :photos do |t|
          t.input :title
          t.input :photo
        end
      end
    f.actions
  end

end
