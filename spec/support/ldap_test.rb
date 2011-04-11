
# Functionality and test setup that is common to all tests that run against
# the ldap server configured in spec/ldap_connection.rb.
# 
# Creates a randomly named 'ou' below your test servers base. Tests should 
# use this ou as container to perform modifications in. The test ou and all
# keys below it are deleted at the end of this test.
#
module LdapTest
  def self.included(base)
    base.let(:connection) { LDAP_CONNECTION }
    base.let(:ou_name) { 'test.'+("%d04"%rand(1000)) }
    base.let(:ou_dn) { "ou=#{ou_name},#{connection.base}" }
    
    base.before(:each) { 
      connection.add(
        :dn => ou_dn,
        :attributes => {
          :ou => ou_name, 
          :objectClass => %w(top organizationalUnit)
        }
      ) or fail "Could not create ou #{ou_name}."
    }
    base.after(:each) { 
      begin
        connection.search(            # Enumerate all dns below the ou_dn
          :base => ou_dn, 
          :attributes => %w(dn)).
          map { |e| e[:dn].first }.   # Extract 'dn' attribute
          sort_by { |e| e.size }.     # Sort by length
          reverse.                    # And put the longest (deepest?) in front
          each do |dn|                # Delete all these.
            connection.delete(:dn => dn)
          end
      rescue Net::LDAP::LdapError
        # Might be 'No such object'
      end
    }

    # If at this point we have no LDAP_CONNECTION, exclude all examples that
    # include this code (and that will certainly access LDAP_CONNECTION).
    if !defined?(LDAP_CONNECTION)
      RSpec.configure do |c|
        c.filter_run_excluding :ldap_test => true
      end
    end
  end
end

# Tell RSpec to include LdapTest in all samples that are tagged :ldap_test.
RSpec.configure do |config|
  config.include LdapTest, :ldap_test => true
end