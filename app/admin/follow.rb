ActiveAdmin.register Follow do
  menu priority: 15
  permit_params :followable_id, :followable_type, :follower_id, :follower_type
end