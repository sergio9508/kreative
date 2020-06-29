#
class LatteController < ApplicationController
  include Pundit

  before_action :authenticate_admin!
  before_action :set_paper_trail_whodunnit
  before_action :set_locale
  after_action  :set_csrf_cookie_for_ng
  #
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def user_for_paper_trail
    admin_signed_in? ? current_admin.id : nil
  end

  def pundit_user
    current_admin
  end

  helper_method :menu_models
  #
  def menu_models
    Rails.application.eager_load!
    ApplicationRecord.descendants.map(&:name).select do |name|
      File
        .exist?(Rails.root.join("app/policies/#{name.underscore}_policy.rb")) &&
        defined?("#{name}Policy") &&
        policy(name.constantize).index?
    end
  end
  
  def default_url_options
    {}
  end

  protected

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

  def set_locale
    if language_change_necessary?
      I18n.locale = the_new_locale
      locale_cookie! I18n.locale
    else
      use_locale_from_cookie
    end
  end

  def language_change_necessary?
    cookies['locale'].blank? || params[:locale]
  end

  def the_new_locale
    params[:locale] || I18n.default_locale
  end

  # Sets the locale cookie
  def locale_cookie!(locale)
    cookies['locale'] = locale.to_s
  end

  # Reads the locale cookie and sets the locale from it
  def use_locale_from_cookie
    I18n.locale = cookies['locale']
  end
end
