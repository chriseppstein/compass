module Compass::Commands
end

require 'compass/commands/registry'

%w(base project_base default help list_frameworks
   update_project watch_project create_project clean_project extension_command
   imports installer_command print_version project_stats stamp_pattern
   sprite validate_project write_configuration interactive unpack_extension
   load_command_extensions
).each do |lib|
  require "compass/commands/#{lib}"
end

Compass::Commands::CommandExtensionLoader.load_extensions_in_config
Compass.discover_extensions!