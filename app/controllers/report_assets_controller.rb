class ReportAssetsController < ApplicationController
  def index
    @council_report = CouncilReport.find(params[:council_report_id])
    @report_assets = @council_report.report_assets
  end
  
  def show
    @council_report = CouncilReport.find(params[:council_report_id])
    @report_asset = @council_report.report_assets.find(params[:id])
  end
  
  def new
    @council_report = CouncilReport.find(params[:council_report_id])
    @report_asset = @council_report.report_assets.build
    @assets_not_in = assets_not_in_report(@council_report)
  end
      
  def create
    @council_report = CouncilReport.find(params[:council_report_id])
    @report_asset = @council_report.report_assets.create(report_asset_params)
    if @report_asset.save
      @asset = Asset.find(@report_asset.asset_id)
      flash[:success] = @asset.asset_name + " added to report " + @council_report.report_title + "."
      redirect_to council_report_path(@council_report)
    else
      render 'new'
    end
  end
  
  def destroy
    @report_asset = ReportAsset.find(params[:id])
    asset = Asset.find(@report_asset.asset_id)
    council_report = CouncilReport.find(@report_asset.council_report_id) 
    @report_asset.destroy
    flash[:success] = asset.asset_name + " removed from the " + council_report.report_title + "."
     
    redirect_to council_report_report_assets_path(council_report)
  end
  
  def generate
    @council_report = CouncilReport.find(params[:council_report_id])
    @report_assets = @council_report.report_assets
    save_success = true
    @report_assets.each do |report_asset|
      ap_items = AssetPriorityItem.where(asset_id: report_asset.asset_id)
      ap_items.each do |ap_item|
        asset_assessment = AssetAssessment.create!(council_report_id: @council_report.id, 
                                                   asset_id: ap_item.asset_id,
                                                   priority_item_id: ap_item.priority_item_id,
                                                   asset_priority_value: 0)
        if !asset_assessment.save
          save_success = false
        end
        break if !save_success
      end
    end
    if save_success
      CouncilReport.update(@council_report.id, :report_generated => true)
      flash[:success] = @council_report.report_title + " Report generated."
      redirect_to council_report_path(@council_report)
    else
      redirect_to council_report_report_assets_path(council_report)
    end
  end
      
  private
    def report_asset_params
      params.require(:report_asset).permit(:council_report_id, :asset_id)
    end 
end
