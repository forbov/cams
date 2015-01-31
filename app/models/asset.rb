# encoding: utf-8 
class Asset < ActiveRecord::Base 

  # attr_accessible  :id, :asset_name, :asset_type, :council, :address

  belongs_to :council
  has_one :address
  has_many :asset_components, dependent: :destroy
  has_many :components, through: :asset_components
  has_many :asset_priority_items, dependent: :destroy
  has_many :priority_items, through: :asset_priority_items
  has_many :report_assets
  has_many :asset_assessments
  has_many :proposed_works 
          
  validates :council_id, presence: true
  validates :asset_name, presence: true
  
  accepts_nested_attributes_for :address
end