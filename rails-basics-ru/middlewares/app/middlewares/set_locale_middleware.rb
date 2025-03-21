# frozen_string_literal: true

class SetLocaleMiddleware
  def initialize(app)
    @app = app
  end

  # BEGIN
  def call(env)
    req = Rack::Request.new(env)
    locale = extract_locale_from_accept_language_header(req) || I18n.default_locale
    I18n.locale = locale.downcase.to_sym

    @app.call env
  end

  def extract_locale_from_accept_language_header(req)
    locale = req.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first

    Rails.logger.debug "* Locale detected as '#{locale}'"

    I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
  end
  # END
end
