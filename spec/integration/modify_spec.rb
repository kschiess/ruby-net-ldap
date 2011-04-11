require 'spec_helper'

describe "Modifying attributes" do
  context "(against LDAP_CONNECTION)", :ldap_test => true do
    let(:entry_dn) { "automountKey=foo,#{ou_dn}" }

    def checked(result)
      unless result
        opres = connection.get_operation_result
        raise "#{opres.message} (#{opres.code})"
      end
    end

    before(:each) { 
      checked connection.add(
        :dn => entry_dn, 
        :attributes => {
          :automountKey => 'foo', 
          :automountInformation => 'foobar', 
          :objectClass => %w(top automount)
        }
      )
    }
    
    it "should replace attributes" do
      checked connection.modify(
        :dn => entry_dn, 
        :operations => [
          [:replace, :automountInformation, ['barbaz']]]
      )
      
      entry = connection.search(
        :base => entry_dn).first
        
      entry["automountInformation"].first.should == 'barbaz'
    end   
  end
end