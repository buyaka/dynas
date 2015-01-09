
class DynamicRouter
  def self.load
    Rails.application.routes.draw do
      Core::App.all.each do |b|
        puts "Routing #{b.name}"
        get "/#{b.name}", :to => "crud#show", defaults: { id: b.id }
      end
    end
  end

  def self.reload
    Rails.application.routes_reloader.reload!
  end
end
