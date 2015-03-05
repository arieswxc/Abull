ActiveAdmin.register Topic do
  permit_params :user_id, :title, :content, :date
end