class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource) 
        plans_path
    end
    
    def after_sign_out_path_for(resource)
        root_path
    end
    
    def create
     user = User.find(params[:id])
      if user.save
        redirect_to root_path, notice: "ユーザーを作成しました"
      else
        render :new
      end
    end
end
