#
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action { set_meta_tags Setting.metatags }

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    return latte_root_url if resource_or_scope == :admin
    super
  end
  # before_action :set_locale

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end

  # def default_url_options
  #   { locale: I18n.locale }
  # end
end
