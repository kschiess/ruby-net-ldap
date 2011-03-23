require 'spec_helper'

describe "Searching" do
  context "(against LDAP_CONNECTION)", :if => :ldap_available do
    let(:connection) { LDAP_CONNECTION }
    it "returns entries for a wildcard search" do
      n = 0
      result = connection.search(:attributes => nil) { n += 1 }
      n.should > 0
      result.size.should == n
    end
  end
end