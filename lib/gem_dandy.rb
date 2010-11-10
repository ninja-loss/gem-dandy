require 'trollop'
require 'yaml'
# Dir.glob "#{File.dirname __FILE__}/gem_dandy/*.rb" do |f|
#   require File.expand_path( "#{File.dirname __FILE__}/gem_dandy/" +
#                             File.basename( f, '.rb' ) )
# end

module GemDandy
  autoload :Command,          'gem_dandy/command'
  autoload :ConfigFile,       'gem_dandy/config_file'
  autoload :Configuration,    'gem_dandy/configuration'
  autoload :Output,           'gem_dandy/output'
  autoload :RubyforgeProfile, 'gem_dandy/rubyforge_profile'

  VERSION = File.read( "#{File.dirname __FILE__}/../VERSION" ).chomp
end

SUB_COMMANDS = %w(config profile)
global_opts = Trollop::options do
  version "v0.1.0 (c) 2010 ninja-loss"
  banner <<-EOS
Managing Gems does not have to be scary.

Usage:
  gemdandy [sub-command] [options]

sub-commands:
  config
  profile

(For help with a sub-command: gemdandy [sub-command] -h)

options:
EOS
  # opt :dry_run, "Perform a dry run", :short => "-n"
  stop_on SUB_COMMANDS
end

# Get the sub-command and its options
#
cmd = ARGV.shift || ''
cmd_opts = case( cmd )
  when "config"
    Trollop::options do
      opt :clear,   "Clear the ~/.gemdandyrc file"
      opt :profile, "The name of the profile",     :type => String
      opt :key,     "The RubyGems API key",       :type => String
    end
  when "profile"
    Trollop::options do
      opt :active, "Show the currently active RubyGems profile"
      opt :list,   "List all of the configured RubyGems profiles / API keys"
      opt :show,   "Show the configured RubyGems API key for profile <s>",   :type => String, :short => "-z"
      opt :switch, "Switch the currently active RubyGems profile to <s>",    :type => String
    end
  else
    Trollop::die "unknown command #{cmd.inspect}"
  end

# Execute the command
#
case( cmd )
  when "config"
    GemDandy::Configuration.new( cmd_opts ).perform_action
  when "profile"
    GemDandy::RubyforgeProfile.new( cmd_opts ).perform_action
  end