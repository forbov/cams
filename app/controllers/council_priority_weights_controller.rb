class CouncilPriorityWeightsController < ApplicationController
  def index
    @council = Council.find(params[:council_id])
    @council_priority_weights = council_priority_weights_ordered(@council.id)
  end  
end
