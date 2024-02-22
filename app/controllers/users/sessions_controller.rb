# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # include ActionController::Flash
  # respond_to :json
  # def create
  #   # super do |resource|
  #   #   set_flash_message!(:notice, :signed_in)
  #   # end
  #   user = User.find_by(email: login_params[:email])
  #   if user && user.valid_password?(login_params[:password])
  #     @current_user = user
  #     render json: { user: user.attributes.except('password',
  #                     'password_confirmation'), status: 200},
  #                                                 status: 200
  #   else
  #     render json: {message: "Error, Unauthorized", status: 401},
  #            status: :unauthorized
  #   end
  # end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  #  private
  # def login_params
  #   params.permit(:email, :password, :password_confirmation)
  # end
end
