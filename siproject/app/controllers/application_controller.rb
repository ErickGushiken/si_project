class ApplicationController < ActionController::Base
    helper_method :current_user

    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      else
        @current_user = nil
      end
    end

    def is_admin
      if current_user.nil?
        redirect_to login_url, alert: "Acesso Negado, apenas administradores podem acessar essa página"
      else
        if current_user.tipo != 2
          redirect_to login_url, alert: "Acesso Negado, apenas administradores podem acessar essa página"
        end
      end
    end

    def is_consumer
      if current_user.nil?
        redirect_to login_url, alert: "Acesso Negado, apenas compradores podem acessar essa página"
      else
        if current_user.tipo != 1
          redirect_to login_url, alert: "Acesso Negado, apenas compradores podem acessar essa página"
        end
      end
    end

    def is_seller
      if current_user.nil?
        redirect_to login_url, alert: "Acesso Negado, apenas vendedores podem acessar essa página"
      else
        if current_user.tipo != 0
          redirect_to login_url, alert: "Acesso Negado, apenas vendedores podem acessar essa página"
        end
      end
    end
end