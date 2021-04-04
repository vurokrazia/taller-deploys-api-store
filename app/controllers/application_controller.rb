class ApplicationController < ActionController::API
    before_action :switch_locale
    def switch_locale
       I18n.locale = params[:locale] || I18n.default_locale 
    end
end
