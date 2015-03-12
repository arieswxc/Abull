class AddRoleToAdminUsers < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    AdminUser.create!(email: 'admin@example.com', password: 'password123', password_confirmation: 'password123', role: "customer_service") if direction == :up
  end
  def change
    add_column :admin_users, :role, :string
  end
end
