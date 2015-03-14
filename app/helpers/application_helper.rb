module ApplicationHelper
  def check_user(user)
    [ "risk_controller", "customer_service" ].include?(user.role) ? true : false
  end

end
