class ReportsController < ApplicationController
  
  def index
    @council_report = CouncilReport.find(params[:council_report_id])
  end

  def run_report(report_name, report)
    report_url = Global.jasperserver.url + 'rest_v2/reports/reports/cams/' + report_name + '.pdf' + 
                  '?council_report_id=' + report.id.to_s + 
                  '&j_username=' + Global.jasperserver.username + '&j_password=' + Global.jasperserver.password
    
    
    begin
      response = RestClient.get report_url
    rescue => e
      flash[:alert] = "Reports server request failed. Error: " + e.response.code.to_s
      redirect_to council_report_reports_path(report)
    end
    send_data response.body, filename: report_name + ".pdf", disposition: "attachment", :content_type => 'application/pdf'
  end

  def proposed_works_summary
    @council_report = CouncilReport.find(params[:council_report_id])
    run_report('proposed_works_summary', @council_report)
  end

  def weighted_proposed_works
    @council_report = CouncilReport.find(params[:council_report_id])
    run_report('weighted_proposed_works', @council_report)
  end
  
  def bollocks
    report_url = 'http://cbcdn1.gp-static.com/uploads/product_manual/file/490/UM_H4Black_ENG_REVD_WEB.pdf'
    begin
      response = RestClient.get report_url
    rescue => e
      flash[:alert] = "Reports server request failed. Error: " + e.response.code.to_s
      redirect_to council_report_reports_path(report)
    end
    send_data response.body, filename: "bollocks.pdf", disposition: "attachment", :content_type => 'application/pdf'
  end
end
