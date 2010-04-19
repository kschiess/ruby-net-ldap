
require 'yaml'

class Connections  
  # Loads the connections in spec/ldap.yml. Returns an instance of the
  # collection.
  #
  def self.load
    Connections.new.load(File.join(File.dirname(__FILE__), '../ldap.yml'))
  end
  
  def load(config_file_path)
    unless File.exist?(config_file_path)
      raise "No connections configured. Please have a look at spec/ldap.yml.template to find out how."
    end
    
    @config = symbolize_keys(
      YAML.load_file(
        config_file_path))
      
    unless @config[:admin]
      raise "Please configure at least the 'admin' connection, most tests rely on this."
    end
    
    @config.map { |name, props| [name, props[:settings]] }
  end
  
private
  def symbolize_keys(hash)
    hash.inject({}) do |h, (k,v)|
      h.tap { |h| 
        v = symbolize_keys(v) if v.instance_of?(Hash)
        h[k.to_sym] = v 
      }
    end
  end
end