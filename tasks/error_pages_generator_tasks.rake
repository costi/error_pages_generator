# TODO - add template detection in rails app, add default template for the plugin if the app template does not exist. Request the existance of the 500.erb.html and 404.erb.html.
# 
desc "Creates error pages"
task :generate_error_pages => :environment do
  class ErrorPage
    ERROR_PAGES = ['404', '500']
    def find(page)
      ERROR_PAGES.find(lambda{raise StandardError::ArgumentError,'Need a known error code'}) do |error_code|
                           error_code == params[:error_code] 
                         end
    end
  end

  class ErrorPagesController < ApplicationController
    def show
      render ErrorPage.find(params[:error_code]
    end

  end
  require 'action_controller/integration'
  ActionController::Routing::Routes.add_route 'error_page/:error_code', 
                                 :controller => 'error_pages', :action => 'show'
  app = ActionController::Integration::Session.new
  ERROR_PAGES.each do |action|
    app.get "/error_page/#{action}" 
    File.open(File.join(RAILS_ROOT, "public", "#{action}.html"), "w") { |f| f.write app.response.body }
  end
end

