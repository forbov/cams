class CouncilReportsController < ApplicationController
    def index
    @council_reports = CouncilReport.where(council_id: @current_user.council_id)
  end
  
  def show
    @council_report = CouncilReport.find(params[:id])
  end

  def new
    @council_report = CouncilReport.new
  end
    
  def create
    @council_report = CouncilReport.new(council_report_params)
    @council_report.council_id = @current_user.council_id
    @council_report.user_id = @current_user.id
    
    if @council_report.save
      create_asset_assessments(@council_report)
      flash[:success] = @council_report.report_title + " created."
      redirect_to council_report_path(@council_report)
    else
      render 'new'
    end
  end
  
  def edit
    @council_report = CouncilReport.find(params[:id])
  end
  
  def update
    @council_report = CouncilReport.find(params[:id])
    
    if @council_report.update(council_report_params)
      flash[:success] = @council_report.report_title + " updated."
      redirect_to council_report_path(@council_report)
    else
      render 'edit'
    end
  end
    
  def destroy
    @council_report = CouncilReport.find(params[:id])
    @council_report.destroy
    flash[:success] = @council_report.report_title + " removed."
     
    redirect_to council_reports_path
  end

  def select_assets
    @council_report = CouncilReport.find(params[:id])
    @assets_not_in = assets_not_in_report(@council_report)
  end
  
  def save_assets
    success = true
    @council_report = CouncilReport.find(params[:id])
    @assets_to_check = params[:assets_to_check]

    assets_added = 0
    @assets_to_check.each do |record_key, this_asset|  
      if this_asset["add_asset"].to_i == 1
        report_asset = ReportAsset.create!(council_report_id: @council_report.id, 
                                           asset_id: this_asset["id"].to_i)
        if report_asset.save
          assets_added += 1
        else 
          success = false
        end
      end
      break if !success
    end

    if success
      flash[:success] = assets_added.to_s + " assets added to report " + @council_report.report_title + "."
      redirect_to council_report_report_assets_path(@council_report)
    else
      render 'select_assets'
    end
  end


  private
    def council_report_params
      params.require(:council_report).permit(:report_title, :report_desc, :report_date, :user_id)
    end
    
  private
    def create_asset_assessments(council_report)
      for api in AssetPriorityItem.joins(:asset).where(assets: { council_id: council_report.council_id })
        asset_assessment = AssetAssessment.create!(:council_report_id => council_report.id, :asset_id => api.asset_id, 
                                                   :priority_item_id => api.priority_item_id, :asset_priority_value => 0)
        asset_assessment.save
      end
    end
end
