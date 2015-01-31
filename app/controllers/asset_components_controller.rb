class AssetComponentsController < ApplicationController
  def index
    @asset = Asset.find(params[:asset_id])
    @asset_components = @asset.asset_components
  end
  
  def show
    @asset = Asset.find(params[:asset_id])
    @asset_component = @asset.asset_components.find(params[:id])
  end
  
  def edit
    @asset = Asset.find(params[:asset_id])
    @asset_component = @asset.asset_components.find(params[:id])
  end
  
  def update
    @asset = Asset.find(params[:asset_id])
    @asset_component = @asset.asset_components.find(params[:id])
    
    if @asset_component.update_attributes(asset_component_params)
      component = Component.find(@asset_component.component_id)
      flash[:success] = component.component_name + " updated for asset " + @asset.asset_name + "." 
      redirect_to asset_asset_component_path(@asset, @asset_component)
    else
      render 'edit'
    end
  end
      
  private
    def asset_component_params
      params.require(:asset_component).permit(:asset_id, :component_id, :requirement)
    end
end
