# encoding: utf-8 
class SystemCode < ActiveRecord::Base 

  #attr_accessible  :id, :system_code_category, :system_code, :system_code_desc
  
  # Composite primary key
  self.primary_keys = 'system_code_type', 'system_code'

  validates :system_code, :presence => true

end