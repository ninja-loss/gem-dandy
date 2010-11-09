module GemDandy
  class Configuration < Command
    include ConfigFile
    include Output

    def perform_action
      if options[:clear_given]
        clear_config
      else
        confirm_add_to_config_options
        add_to_config( options[:profile], options[:key] )
        confirm_add_to_config_success
      end
    end

  private

    def add_to_config( profile, key )
      keys = api_keys.merge( profile => key )
      remove_config_file
      write_config_file( keys )
    end

    def clear_config
      remove_config_file
      write_config_file( {} )
      report "Successfully cleared the ~/#{config_file_name} file"
    end

    def confirm_add_to_config_success
      new_key = find_api_key( options[:profile] )
      msg = new_key == options[:key] ?
        "Successfully added #{options[:key]} key to #{options[:profile]} profile" :
        "Failed to add new Ruby forge API key: #{options[:key]}"
      report msg
    end

    def remove_config_file
      if File.exists?( gemdandy_rc_file )
        `rm #{gemdandy_rc_file}`
      end
    end

    def write_config_file( key_hash )
      File.open( gemdandy_rc_file, 'w' ) do |f|
        f.write YAML::dump( key_hash )
      end
    end

    def confirm_add_to_config_options
      die( :profile, "is required" ) unless options[:profile]
      die( :key,     "is required" ) unless options[:key]
    end
  end
end