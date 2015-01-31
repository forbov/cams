class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include SystemCodesHelper
  include CouncilReportsHelper
  include CouncilsHelper
  include ReportAssetsHelper
  include ReportsHelper
  
  before_filter :init_globals
  
end
