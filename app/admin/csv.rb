ActiveAdmin.register_page "Csv" do
  content do
    panel "解析账单程序" do
      # div do
      #   link_to t('执行'), admin_csv_add_event_path, :method => :get, :class => 'button' 
      # end
      # div do
      #   link_to t("file")
      # end
      # para link_to t("上传每日账单数据"), admin_csv_file_path(CsvFile.find_by(title: "每日账单数据"))
      para link_to t('执行'), admin_csv_add_event_path, :method => :get, :class => 'button' 
    end
    panel "导入利率表" do
      # div do
      #   link_to t('执行'), admin_csv_add_event_path, :method => :get, :class => 'button' 
      # end
      # div do
      #   link_to t("file")
      # end
      # para link_to t("上传利率表"), admin_csv_file_path(CsvFile.find_by(title: "利率表"))
      para link_to t('执行'), admin_csv_parse_interest_path, :method => :get, :class => 'button' 
    end
  end
  page_action :add_event, method: :get do 
    %x[ rake data:update_homs]
    redirect_to admin_csv_path, notice: "执行成功"
  end

  page_action :parse_interest, method: :get do
    %x[ rake data:import_interests]
    redirect_to admin_csv_path, notice: "执行成功"
  end
end
