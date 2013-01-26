class Client < ActiveRecord::Base
  has_many :invoices
  attr_accessible :invoices

  def self.with_unpaid_invoices
    includes(:invoices).
      where('invoices.paid = ?', false)
  end
end