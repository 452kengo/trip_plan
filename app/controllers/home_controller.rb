class HomeController < ApplicationController
    def after_sign_in_path_for(resource) 
        plans_path
    end
end