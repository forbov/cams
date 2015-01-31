# encoding: utf-8 
class PriorityItem < ActiveRecord::Base 

  #attr_accessible  :id, :priority_category_code, :priority_item_desc

  has_many :priority_item_values, dependent: :destroy
  has_many :asset_priority_items, dependent: :destroy 
  has_many :assets, through: :asset_priority_items
  has_many :asset_assessments
  has_many :council_priority_weights

end