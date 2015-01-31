# encoding: utf-8 
class Component < ActiveRecord::Base 

  #attr_accessible  :id, :asset_type, :component_name, :component_desc, :default_requirement

  has_many :asset_components 
  has_many :assets, through: :asset_components 
  has_many :proposed_works

end