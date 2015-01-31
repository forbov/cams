class ReportAsset < ActiveRecord::Base
  belongs_to :council_reports
  belongs_to :assets
end
