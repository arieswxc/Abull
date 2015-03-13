ActiveAdmin.register Topic do
  permit_params :user_id, :title, :content, :date

  index do
    selectable_column
    id_column
    column "标题", :title
    column "日期", :date
    column "用户ID", :user_id
    column "内容" do |topic|
      topic.content.slice(0,140)
    end
    actions
  end

  show do |topic|
    attributes_table do
      row('标题')    { |t| t.title }
      row('内容')    { |t| t.content }
      row('用户ID')  { |t| t.user_id }
    end
  end

  form do |f|
    f.inputs "topic Details" do
      f.input :title
      f.input :content
      f.input :user_id
    end
    f.actions
  end
end