# encoding: utf-8 
class AssetAssessment < ActiveRecord::Base 

  #attr_accessible  :council_report, :asset_priority_item, :asset_priority_value

  belongs_to :council_report 
  belongs_to :asset
  belongs_to :priority_item 

  # Composite primary key 
#  validates :id, :uniqueness => { :scope => [ :asset_id , :asset_priority_item_id ] } 
  validates :asset_priority_value, :presence => true

end