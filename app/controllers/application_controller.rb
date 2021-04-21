class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  helper_method :current_cart

  def current_cart
    @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
    
  end
   
    

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday])
  end

  


end
