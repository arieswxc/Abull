ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :role
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email if current_admin_user.role == "admin"
      f.input :role, as: :select, collection: ["risk_controller", "teller", "account_manager", "customer_service"] if current_admin_user.role == "admin"
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
