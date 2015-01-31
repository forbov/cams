class AssetPriorityItem < ActiveRecord::Base
  
  belongs_to :asset
  belongs_to :priority_item
  
end
