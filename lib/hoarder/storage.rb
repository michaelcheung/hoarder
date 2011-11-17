module Hoarder
  class Storage

    def initialize(path)
      @absolute_path = path
      @config = load_config("#{@absolute_path}/hoarder.yml")
      @public = @config['public'] || true
      @connection = set_connection(@config['provider'], @config)
      @locker = set_locker(@config['container'], @public)
    end

    def absolute_path
      @absolute_path 
    end

    def locker
      @locker 
    end

    def public
      @public 
    end
    
    def load_config(config_file)
      if FileTest.exist?(config_file)
        begin
          config = File.open(config_file) {|yf| YAML::load(yf)} || {}
          validate_config(config)
        rescue
          raise "Unable to load config file #{config_file}."
        end
      else
        raise "Missing config file #{config_file}."
      end
      config
    end
    private :load_config

    def set_connection(provider, options = {})
      Fog::Storage.new({
        :provider => 'Rackspace',
        :rackspace_api_key => options['rackspace_api_key'],
        :rackspace_username => options['rackspace_username']
      })
    end
    private :set_connection

    def set_locker(name, make_public)
      locker = @connection.directories.get(name)
      locker.nil? ? @connection.directories.create(:key => name, :public => make_public) : locker
    end
    private :set_locker

    def validate_config(config)
      raise if config.empty?
    end
    private :validate_config

  end
end
