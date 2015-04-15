ActiveAdmin.register News do
  menu priority: 16
  permit_params :title, :content, :date
end