ActiveAdmin.register Photo do
  permit_params :title, :photo, :user_id

  index do
    selectable_column
    id_column
    column "标题", :title
    column "图像" do |p|
      image_tag p.photo 
    end
    column "用户", :user_id
    actions
  end

  show do |photo|
    attributes_table do
      row('标题')    { |p| p.title }
      row('图像')    { |p| image_tag p.photo }
      row('用户ID')  { |p| p.user_id }
    end
  end

  form do |f|
    f.inputs "Photo Details" do
      f.input :title
      f.input :photo
      f.input :user_id
    end
    f.actions
  end

end
