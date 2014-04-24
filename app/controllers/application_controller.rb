class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html
  layout 'buergerrechte_waehlen/application'
  before_action :set_locale

  def set_locale
    I18n.locale = 'de'
  end
end
