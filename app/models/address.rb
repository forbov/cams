# encoding: utf-8 
class Address < ActiveRecord::Base 

  #attr_accessible  :id, :address_line_1, :address_line_2, :city, :postcode, :state_code

  def address_long
    if self.address_line_2 then
      return self.address_line_1 + " " + self.address_line_2 + " " + self.city
    else
      return self.address_line_1 + " " + self.city
    end
  end

  belongs_to :council 
  belongs_to :asset

  validates :address_line_1, presence: true
  validates :city, presence: true
  validates :postcode, presence: true, length: { is: 4 }
  
  validates :state_code, presence: true, length: { maximum: 10 }

end