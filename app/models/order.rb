class Order < ApplicationRecord
	belongs_to :user
  belongs_to :product, optional: true

  def pretty_time
  		created_at.strftime("%A, %b %d")
	end
end
