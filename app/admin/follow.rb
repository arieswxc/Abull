ActiveAdmin.register Follow do
  permit_params :followable_id, :followable_type, :follower_id, :follower_type
end