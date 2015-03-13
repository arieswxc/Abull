ActiveAdmin.register Topic do
  permit_params :user_id, :title, :content, :date

  index do
    selectable_column
    id_column
    column :title
    column "用户" do |topic|
      user = AdminUser.find(topic.user_id)
      link_to user.email, admin_admin_user_path(user)
    end
    column "内容" do |topic|
      topic.content.slice(0,500) + "..."
    end
    column :date
    actions
  end

  show do |topic|
    attributes_table do
      row('标题')    { |t| t.title }
      row('内容')    { |t| t.content }
      row('用户') do 
        user = AdminUser.find(topic.user_id)
        link_to user.email, admin_admin_user_path(user)
      end
      row :date
    end
  end

  form do |f|
    f.inputs "topic Details" do
      f.input :title
      f.input :content
      f.input :user_id, as: :select, collection: [ current_admin_user.id ]
    end
    f.actions
  end
  
end