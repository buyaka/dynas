module Backend
  class Engine < ::Rails::Engine
    isolate_namespace Backend
  end
end
