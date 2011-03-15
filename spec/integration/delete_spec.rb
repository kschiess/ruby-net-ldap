require 'spec_helper'

describe "Deleting entries" do
  context "when mocking the connection entirely" do
    let(:ldap) { Net::LDAP.new() }
    let(:socket) { flexmock(:tcp_socket) }
    let(:connection) { Net::LDAP::Connection.new({}) }

    # Replace all new sockets with socket
    before(:each) { 
      flexmock(TCPSocket).
        should_receive(:new => socket)
    }
    
    # Define a few default operations for socket
    before(:each) { 
      socket.should_receive(
        :write => nil,
        :read_ber => nil,
        :close => nil).by_default
    }
    
    # Make all open_connection calls on ldap return connection
    before(:each) { 
      flexmock(ldap).
        should_receive(:open_connection).and_yield(connection)
    }
    
    # And finally, replace bind on connection with something that pretends 
    # success: 
    before(:each) { 
      flexmock(connection).
        should_receive(:bind => true)
    }
    
    def pdu(result_code)
      flexmock(:pdu, :result_code => result_code)
    end
    
    it "should pass all delete encoding code" do
      flexmock(connection).
        should_receive(:read_pdu).and_return(pdu(11))

      ldap.delete(:dn => 'ou=some,dc=example,dc=com')
    end 
  end
end