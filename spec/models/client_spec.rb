require 'spec_helper'

describe Client do
  use_natural_assertions

  describe ".with_unpaid_invoices" do
    Given!(:paid_up_client) { Client.create!(invoices: [Invoice.new(paid: true)]) }

    Given(:paid_invoice) { Invoice.new(paid: true) }
    Given(:unpaid_invoice) { Invoice.new(paid: false) }
    Given!(:behind_client) { Client.create!(invoices: [paid_invoice, unpaid_invoice]) }

    When(:results) { Client.with_unpaid_invoices }

    describe "how it narrows the clients down" do
      Then { results == [behind_client] }
    end

    describe "how it conveniently filters the associated invoices" do
      When(:invoices) { results.first.invoices }
      Then { invoices == [unpaid_invoice] }
    end

    describe "how that convenience falls flat so easily" do
      When(:invoices) { results.first.invoices.scoped }
      Then { invoices == [paid_invoice, unpaid_invoice] }
    end
  end
end