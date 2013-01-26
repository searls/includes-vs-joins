class Invoice < ActiveRecord::Base
  belongs_to :client
  attr_accessible :paid
end