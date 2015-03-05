ActiveAdmin.register News do
  permit_params :title, :content, :date
end