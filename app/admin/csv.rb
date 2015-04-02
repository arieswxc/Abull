ActiveAdmin.register_page "Csv" do
  content do
    panel "解析账单程序" do
      link_to t('执行'), admin_csv_add_event_path, :method => :get, :class => 'button' 
    end
  end
  page_action :add_event, method: :get do 
    %x[ rake data:update_homs]
    redirect_to admin_csv_path, notice: "执行成功"
  end
end
