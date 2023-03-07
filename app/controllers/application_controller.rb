class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :store_user_location!, if: :storable_location?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :find_agents_without_delegation, if: :devise_controller?

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: [:index, :my_journeys_index], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Raise an alert if not authorized
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def find_agents_without_delegation
    if current_user && current_user.super_admin?
      @agents_without_delegation = User.all.includes(:agent_delegation).map { |user| user.agent_delegation.present? ? nil : user }.reject { |item| item == nil || item.authorized == false }
      if @agents_without_delegation.size > 0
        return redirect_to admin_dashboard_users_path, alert: 'Un ou plusieurs agents ne sont pas intégrés à une délégation !'
      end
    end
  end

  def after_sign_in_path_for(resource)
    home_path
  end

  def after_sign_up_path_for(resource)
    home_path
  end

  def after_update_path_for(resource)
    home_path
  end

  # def update_resource(resource, params)
  #   # Require current password if user is trying to change password.
  #   return super if params["password"]&.present?
  #   # Allows user to update registration information without password.
  #   resource.update_without_password(params.except("current_password"))
  # end

  def user_not_authorized
    flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
    redirect_to(home_path)
  end

  # verifie que la page peut etre stocker pour ne pas tomber dans une boucle de redirection infinie
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  # stock la page pour que l'utilisateur soit rediriger apres le login
  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def default_url_options
    { host: ENV['DOMAIN'] || "localhost:3000" } # rajouter le nom de domaine en prod
  end

  # equivalent a user_params (qu'est-ce qu'on autorise a etre modifie)
  def configure_permitted_parameters
    # lors de la creation d'un nouveau compte
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(
        :email,
        :password,
        :password_confirmation,
        :first_name,
        :last_name
      )
    end

    # lors de la modification d'un compte deja existant
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(
        :email,
        :password,
        :password_confirmation,
        :current_password,
        :first_name,
        :last_name
      )
    end
  end
end
