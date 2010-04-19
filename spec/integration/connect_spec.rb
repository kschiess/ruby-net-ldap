
require 'spec_helper'

require 'support/connections'

describe Net::LDAP do
  Connections.load.each do |name, settings|
    it "should connect to '#{name}' (ldap.yml)" do
      ldap = Net::LDAP.new(settings)
      raise "Connection to #{name} failed." unless ldap.bind 
    end
  end
end