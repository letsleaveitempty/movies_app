class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def respond_with_json(data, options: {})
    respond_to do |format|
      format.json { render json: data, options: options }
    end
  end
end
