class ApplicationController < ActionController::API
   before_action :user_params, if: :devise_controller?

   rescue_from CanCan::AccessDenied do |exception|
    # respond_to do |format|
    #   format.json { head :forbidden }
    #   format.html { redirect_to root_path, error: exception.message }
    # end
    redirect_to root_url, alert: exception.message
  end
    protected

      def user_params
            devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password,:type)}
      end  
end
