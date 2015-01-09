# requires all dependencies
Gem.loaded_specs['core'].dependencies.each do |d|
 require d.name
end

require "core/engine"

module Core
  #class Engine < ::Rails::Engine
  #    config.to_prepare do
  #      Devise::SessionsController.layout "layout_for_sessions_controller"
  #    end
  #end
end
