class CouncilsController < ApplicationController
  def index
    @councils = Council.all
  end
  
  def show
    @council = Council.find(params[:id])
  end

  def new
    @council = Council.new
    @council.build_address
  end
  
  def create
    @council = Council.new(council_params)
    @council.address.address_type_code = 'COUNCIL'
    if @council.save
      initialise_weights(@council)
      flash[:success] = @council.council_name + " created."
      redirect_to @council
    else
      render 'new'
    end
  end

  def edit
    @council = Council.find(params[:id])
  end
  
  def update
    @council = Council.find(params[:id])
    
    if @council.update(council_params)
      flash[:success] = @council.council_name + " updated."
      redirect_to @council
    else
      render 'edit'
    end
  end
  
  def destroy
     @council = Council.find(params[:id])
     @council.destroy
     flash[:success] = @council.council_name + " removed."
     
     redirect_to councils_path
  end
  
  def adjust_weights
    @council = Council.find(params[:id])
    @current_weights = council_priority_weights_ordered(@council.id)
  end
  
  def save_weights
    success = true
    @council = Council.find(params[:id])
    @adjusted_weights = params[:adjusted_weights]

    #first check weight total == 100
    weight_total = 0
    @adjusted_weights.each do |record_key, this_priority_item|
      weight_total += this_priority_item["priority_weight"].to_f
    end
    if weight_total == 100
      @adjusted_weights.each do |record_key, this_priority_item|
        CouncilPriorityWeight.update(this_priority_item["id"].to_i, 
                                     :priority_weight => this_priority_item["priority_weight"].to_f)
      end
      flash[:success] = "Priority weighting adjusted for " + @council.council_name
      redirect_to council_council_priority_weights_path(@council)
    else
      flash[:alert] = "Priority Weighting total must equal 100"
      redirect_to adjust_weights_council_path(@council)
    end    
  end

  def select_asset_types
    @council = Council.find(params[:id])
    @asset_types_not_in = asset_types_not_in_council(@council)
  end
  
  def save_asset_types
    success = true
    @council = Council.find(params[:id])
    @asset_types_to_check = params[:asset_types_to_check]

    asset_types_added = 0
    @asset_types_to_check.each do |record_key, this_asset_type|  
      if this_asset_type["add_asset_type"].to_i == 1
        council_asset_type = CouncilAssetType.create!(council_id: @council.id, 
                                           asset_type_code: this_asset_type["asset_type_code"])
        if council_asset_type.save
          asset_types_added += 1
        else 
          success = false
        end
      end
      break if !success
    end

    if success
      flash[:success] = asset_types_added.to_s + " asset types added to council " + @council.council_name + "."
      redirect_to council_council_asset_types_path(@council)
    else
      render 'select_asset_types'
    end
  end


  private
    def council_params
      params.require(:council).permit(:council_name, 
                                      address_attributes: [:address_line_1, :address_line_2, :city, :postcode, :state_code])
    end
    
  private 
    def initialise_weights(council)
      priority_items = PriorityItem.all
      priority_items.each do |priority_item|
        council_priority_weight = CouncilPriorityWeight.create!(council_id: council.id, 
                                                                priority_item_id: priority_item.id, 
                                                                priority_weight: priority_item.default_weight)
        council_priority_weight.save
      end
    end
end