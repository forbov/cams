class CouncilPriorityWeight < ActiveRecord::Base
  belongs_to :council
  belongs_to :priority_item
end
