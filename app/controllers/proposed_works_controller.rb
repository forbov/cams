class ProposedWorksController < ApplicationController
  def index
    @council_report = CouncilReport.find(params[:council_report_id])
    @report_assets = report_assets_ordered(@council_report.id)
  end
  
  def show
    @council_report = CouncilReport.find(params[:council_report_id])
    @asset = Asset.find(params[:id])
    @asset_components = AssetComponent.where(asset_id: @asset.id)
  end
  
  def new
    @council_report = CouncilReport.find(params[:council_report_id])
    @asset_component = AssetComponent.find(params[:asset_component_id])
    @asset = Asset.find(@asset_component.asset_id)
    @component = Component.find(@asset_component.component_id)
    @proposed_work = @council_report.proposed_works.build
  end

  def create
    @council_report = CouncilReport.find(params[:council_report_id])
    @proposed_work = @council_report.proposed_works.create(works_params)
    @proposed_work.save
    if @proposed_work.save
      @asset_component = AssetComponent.find(@proposed_work.asset_component_id)
      asset_component = AssetComponent.find(@proposed_work.asset_component_id)
      asset = Asset.find(asset_component.asset_id)
      component = Component.find(asset_component.component_id)
      flash[:success] = @proposed_work.proposed_work + " added for " + asset.asset_name + "/" + component.component_name + "."
      redirect_to council_report_proposed_work_path(@council_report, asset)
    else
      render 'new'
    end
    
  end
  
  def edit
    @council_report = CouncilReport.find(params[:council_report_id])
    @proposed_work = @council_report.proposed_works.find(params[:id])
    @asset_component = AssetComponent.find(@proposed_work.asset_component_id)
    @asset = Asset.find(@asset_component.asset_id)
    @component = Component.find(@asset_component.component_id)
  end
  
  def update
    @council_report = CouncilReport.find(params[:council_report_id])
    @proposed_work = @council_report.proposed_works.find(params[:id])
    if @proposed_work.update(works_params)
      asset_component = AssetComponent.find(@proposed_work.asset_component_id)
      asset = Asset.find(asset_component.asset_id)
      component = Component.find(asset_component.component_id)
      flash[:success] = asset.asset_name + "/" + component.component_name + " proposed works updated."
      redirect_to council_report_proposed_work_path(@council_report, asset)
    else
      render 'edit'
    end
  end

  def destroy
    @council_report = CouncilReport.find(params[:council_report_id])
    @proposed_work = @council_report.proposed_works.find(params[:id])
    asset_component = AssetComponent.find(@proposed_work.asset_component_id)
    asset = Asset.find(asset_component.asset_id)
    component = Component.find(asset_component.component_id)
    @proposed_work.destroy
    flash[:success] = asset.asset_name + " - " + component.component_name + " removed."
     
    redirect_to council_report_proposed_work_path(@council_report, asset)
  end
    
  def piece_of_work
    @council_report = CouncilReport.find(params[:council_report_id])
    @proposed_work = @council_report.proposed_works.find(params[:id])
    @asset_component = AssetComponent.find(@proposed_work.asset_component_id)
    @asset = Asset.find(@asset_component.asset_id)
    @component = Component.find(@asset_component.component_id)
  end
  
  private
    def works_params
      params.require(:proposed_work).permit(:council_report, :asset_component_id, :proposed_work, :priority_level_code, :work_cost, :cost_type_code, :photo)
  end
end