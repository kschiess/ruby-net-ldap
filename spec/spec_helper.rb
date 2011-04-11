require 'net/ldap'

RSpec.configure do |config|
  config.mock_with :flexmock
  
  config.exclusion_filter = {
    # Use :if => :ldap_available to only run tests when acceptance testing
    # ldap connection is available. 
    :if => lambda { |what| 
      case what
        when :ldap_available
          !defined?(LDAP_CONNECTION) 
      end
    }
  }
end

begin
  require 'ldap_connection'
rescue LoadError
  warn "!!!!!!!!!!!!!!! integration tests will not run !!!!!!!!!!!!!!!"
  warn "-> Could not load spec/ldap_connection: Please copy from ldap_connection.rb.template "+
    "and modify to your needs."
end

require 'support/ldap_test'