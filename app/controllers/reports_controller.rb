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
    
    datetime = DateTime.current
    FileUtils.mkdir_p Global.jasperserver.report_dir
    filename = Global.jasperserver.report_dir + '/' + report_name + '_' + report.id.to_s + '_' + datetime.to_s(:number) + '.pdf' 
    f = File.new(filename, 'wb')
    f.write(response.body)
    f.close
    send_file(filename, :type => 'application/pdf', :disposition => 'inline')
  end

  def proposed_works_summary
    @council_report = CouncilReport.find(params[:council_report_id])
    run_report('proposed_works_summary', @council_report)
  end
end
