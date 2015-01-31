class PriorityItemValue < ActiveRecord::Base
  
  def display_value
    return self.valid_value.to_s + " - " + self.value_desc
  end
  
  validates :valid_value, :presence => true
  validates :value_desc, :presence => true

  belongs_to :priority_item
end
