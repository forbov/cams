class CouncilAssetTypesController < ApplicationController
  def index
    @council = Council.find(params[:council_id])
    @council_asset_types = @council.council_asset_types
  end
  
  def show
    @council = Council.find(params[:council_id])
    @council_asset_type = @council.council_asset_type.find(params[:id])
  end
  
  def new
    @council = Council.find(params[:council_id])
    @council_asset_type = @council.council_asset_types.build
    @asset_types_not_in = asset_types_not_in_council(@council)
  end
      
  def create
    @council = Council.find(params[:council_id])
    @council_asset_type = @council.council_asset_types.create(council_asset_type_params)
    if @council_asset_type.save
      flash[:success] = asset_type_desc(@council_asset_type.asset_type_code) + " added to council " + @council.council_name + "."
      redirect_to council_path(@council)
    else
      render 'new'
    end
  end
  
  def destroy
    @council_asset_type = CouncilAssetType.find(params[:id])
    council = Council.find(@council_asset_type.council_id) 
    @council_asset_type.destroy
    flash[:success] = asset_type_desc(@council_asset_type.asset_type_code) + " removed from council " + council.council_name + "."     
    redirect_to council_council_asset_types_path(council)
  end
  
  private
    def council_asset_type_params
      params.require(:council_asset_type).permit(:council_id, :asset_type_code)
    end
end
