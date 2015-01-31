# encoding: utf-8 
class Council < ActiveRecord::Base 

  # attr_accessible  :id, :council_name, :address

  has_one :address 
  has_many :users, dependent: :destroy 
  has_many :assets, dependent: :destroy 
  has_many :addresses, through: :assets 
  has_many :council_reports, dependent: :destroy
  has_many :council_priority_weights, dependent: :destroy 
  has_many :council_asset_types, dependent: :destroy
  
  accepts_nested_attributes_for :address
end