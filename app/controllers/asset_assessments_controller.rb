class AssetAssessmentsController < ApplicationController
  def index
    @council_report = CouncilReport.find(params[:council_report_id])
    @report_assets = report_assets_ordered(@council_report.id)
  end
  
  def show
    @council_report = CouncilReport.find(params[:council_report_id])
    @asset = Asset.find(params[:id])
    @asset_assessments = @council_report.asset_assessments.where(asset_id: @asset.id)
  end

  def edit
    @council_report = CouncilReport.find(params[:council_report_id])
    @asset_assessment = @council_report.asset_assessments.find(params[:id])
  end
  
  def update
    @council_report = CouncilReport.find(params[:council_report_id])
    @asset_assessment = @council_report.asset_assessments.find(params[:id])
    asset = Asset.find(@asset_assessment.asset_id)
    if @asset_assessment.update(assessment_params)
      flash[:success] = asset.asset_name + " priority re-assessed."
      redirect_to council_report_asset_assessment_path(@council_report, asset)
    else
      render 'edit'
    end
  end
    
  private
    def assessment_params
      params.require(:asset_assessment).permit(:council_report, :asset, :priority_item, :asset_priority_value)
    end
end
