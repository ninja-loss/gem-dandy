module GemDandy
  module ConfigFile
    def api_keys
      return File.exists?( gemdandy_rc_file ) ?
        YAML::load( File.open( gemdandy_rc_file ) ) :
        {}
    end

    def find_api_key( identifier )
      api_keys[identifier]
    end

    def gemdandy_rc_file
      "#{File.expand_path( '~' )}/#{config_file_name}"
    end

    def config_file_name
      '.gemdandyrc'
    end
  end
end