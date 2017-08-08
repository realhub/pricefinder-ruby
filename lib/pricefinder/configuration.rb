module Pricefinder
  class Configuration

    CONFIG_PARAMS = [:client_id, :client_secret]
    
    attr_accessor *CONFIG_PARAMS

    # Creates the configuration
    # @param [Hash] hash containing configuration params and their values
    # @return [Configuration] a new configuration with the values from the
    # config_params set
    def initialize(config_hash = nil)
      if config_hash.is_a?(Hash)
        config_hash.each do |config_name, config_value|
          self.send("#{config_name}=", config_value)
        end
      end
    end

    # Returns a hash of config params and their values
    def config_params
      CONFIG_PARAMS.inject({}) do |keys_hash, key|
        keys_hash[key] = send(key)
        keys_hash
      end
    end

    # Check that we have all the required params
    def valid?
      CONFIG_PARAMS.none?{ |key| send(key).nil? || send(key).empty? }
    end
  end
end
