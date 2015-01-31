class AssetComponent < ActiveRecord::Base
    
  #attr_accessible  :asset, :component, :requirement
  
  belongs_to :component 
  belongs_to :asset
  has_many :proposed_works 
  

end
