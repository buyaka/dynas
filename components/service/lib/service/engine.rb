module Service
  class Engine < ::Rails::Engine
    isolate_namespace Service
  end
end
