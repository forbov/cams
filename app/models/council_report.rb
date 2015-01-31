# encoding: utf-8 
class CouncilReport < ActiveRecord::Base 

  #attr_accessible  :id, :user, :report_title, :report_desc, :report_date, :council

  belongs_to :user 
  belongs_to :council
  has_many :report_assets, dependent: :destroy
  has_many :proposed_works, dependent: :destroy
  has_many :asset_assessments, dependent: :destroy 

  validates :report_title, :presence => true
  validates :report_desc, :presence => true
  validates :report_date, :presence => true

end