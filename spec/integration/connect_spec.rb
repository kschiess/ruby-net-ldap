
require 'spec_helper'

require 'support/connections'

describe Net::LDAP do
  Connections.load.each do |name, settings|
    it "should connect using #{name} and allow a simple query" do
      ldap = Net::LDAP.new(settings)
      ldap.bind or raise
      
       # ldap.search(:base => treebase, :filter => filter) do |entry|
       #   puts "DN: #{entry.dn}"
       #   entry.each do |attribute, values|
       #     puts "   #{attribute}:"
       #     values.each do |value|
       #       puts "      --->#{value}"
       #     end
       #   end
       # end
    end
  end
end