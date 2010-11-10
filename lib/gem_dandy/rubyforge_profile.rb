module GemDandy
  class RubyforgeProfile < Command
    include ConfigFile
    include Output

    def perform_action
      perform_checks

      if options[:switch_given]
        switch_profile_to( options[:switch] )
        display_active_profile
      elsif options[:list_given]
        list_configured_profiles
      elsif options[:show_given]
        confirm_show_configured_profile_options
        show_configured_profile( options[:show] )
      else
        display_active_profile
      end
    end

  private

    def perform_checks
      unless File.exists?( gemdandy_rc_file )
        die "The ~/.gemdandyrc file does not exist.  Please run 'gemdandy config -p <profile-name> -k <key>"
      end
    end

    def display_active_profile
      report "Active RubyGems Profile: #{current_profile}"
    end

    def list_configured_profiles
      report api_keys.sort.map { |k,v| "#{k}: #{v}" }.join( "\n" )
    end

    def show_configured_profile( identifier )
      key = find_api_key( identifier )
      msg = (key.nil? || key.empty?) ?
        "There is no RubyGems API key configured for the #{identifier} profile" :
        "#{identifier}: #{key}"
      report msg
    end

    def confirm_show_configured_profile_options
      die( :show, "is required" ) unless options[:show]
    end

    def switch_profile_to( identifier )
      report "Switching active RubyGems profile to #{options[:switch]}..."
      credentials_hash = deployed_key_hash || {}
      unless key = find_api_key( identifier )
        die "#{identifier} is not a configured RubyGems API profile."
      end
      credentials_hash.merge!( credentials_key => key )
      remove_credentials_file
      write_credentials_file( credentials_hash )
    end

    def remove_credentials_file
      if File.exists?( gem_credentials_file )
        `rm #{gem_credentials_file}`
      end
    end

    def write_credentials_file( credentials_hash )
      File.open( gem_credentials_file, 'w' ) do |f|
        f.write YAML::dump( credentials_hash )
      end
    end

    def deployed_key_hash
      return File.exists?( gem_credentials_file ) ?
        YAML::load( File.open( gem_credentials_file ) ) :
        {}
    end

    def deployed_key
      deployed_key_hash[credentials_key]
    end

    def credentials_key
      :rubygems_api_key
    end

    def current_profile
      api_keys.invert[deployed_key]
    end

    def gem_credentials_file
      "#{File.expand_path( '~' )}/.gem/credentials"
    end
  end
end