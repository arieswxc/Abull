ActiveAdmin.register Interest do
  permit_params :leverage_time, :amount, :duration, :interest_rate, :managerment_fee, :show

  form do |f|
    f.inputs "Photo Details" do
      f.input :leverage_time
      f.input :amount
      f.input :duration
      f.input :interest_rate
      f.input :managerment_fee
      f.input :show, collection: ["false", "true"]  
    end
    f.actions
  end
end