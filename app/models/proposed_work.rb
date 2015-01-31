# encoding: utf-8 
class ProposedWork < ActiveRecord::Base 

  #attr_accessible  :council_report, :asset_component, :proposed_work, :priority_level_code, :work_cost, :cost_type_code

  belongs_to :asset_component 
  belongs_to :council_report 
  
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "50x50>" }, 
                    :default_url => "/images/missing_:style.png",
                    :url => "/images/proposed_works/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/images/proposed_works/:id/:style/:basename.:extension"
  
  validates_attachment_content_type :photo, :content_type => ["image/jpeg", "image/png"]

  # Composite primary key 
  validates :proposed_work, :presence => true
  validates :priority_level_code, :presence => true
  validates :work_cost, :presence => true
  validates :cost_type_code, :presence => true

end