class AssetsController < ApplicationController
  def index
    @assets = Asset.where(council_id: @current_user.council_id).order(:asset_type_code, :id)
  end
  
  def show
    @asset = Asset.find(params[:id])
  end

  def new
    @asset = Asset.new
    @asset.build_address
  end
    
  def create
    @asset = Asset.new(asset_params)
    @asset.council_id = @current_user.council_id
    @asset.address.address_type_code = 'ASSET'
    if @asset.save
      create_asset_components(@asset)
      create_asset_priority_items(@asset)
      flash[:success] = @asset.asset_name + " created."
      redirect_to asset_path(@asset)
    else
      render 'new'
    end
  end
  
  def edit
    @asset = Asset.find(params[:id])
  end
  
  def update
    @asset = Asset.find(params[:id])
    
    if @asset.update(asset_params)
      flash[:success] = @asset.asset_name + " updated."
      redirect_to asset_path(@asset)
    else
      render 'edit'
    end
  end
    
  def destroy
    @asset = @asset.find(params[:id])
    @asset.destroy
    flash[:success] = @asset.asset_name + " removed."
     
    redirect_to assets_path
  end

  private
    def asset_params
      params.require(:asset).permit(:asset_name, :asset_type_code, :council_id, 
                                    address_attributes: [:address_line_1, :address_line_2, :city, :postcode, :state_code])
    end
    
  private
    def create_asset_components(asset)
      for component in Component.where(asset_type_code: asset.asset_type_code)
        asset_component = AssetComponent.create!(:asset => asset, :component => component, :requirement => component.default_requirement)
        asset_component.save
      end
    end
    
  private
    def create_asset_priority_items(asset)
      for priority_item in PriorityItem.all
        asset_priority_item = AssetPriorityItem.create!(:asset => asset, :priority_item => priority_item)
        asset_priority_item.save
      end
    end
end
