# frozen_string_literal: true

require 'open-uri'

class Hacker
  class << self
    def self.hack(email, password)
      new.hack(email, password)
    end
  
    def initialize
      @uri = URI('https://rails-collective-blog-ru.hexlet.app')
      @http_client = create_http_client
    end
  
    def hack(email, password)
      response = registrate_a_new_user(email, password)
      response.code == '303' || '302'
    end
  
    private
  
    def registrate_a_new_user(email, password)
      cookie, auth_token = extract_cookie_and_auth_token
  
      request = Net::HTTP::Post.new URI.join(@uri, '/users')
      request.body = build_params(auth_token, email, password)
      request['Cookie'] = cookie
  
      @http_client.request request
    end
  
    def extract_cookie_and_auth_token
      response = make_get_request_to_registration_page
      cookie = response.response['set-cookie'].split('\; ')[0]
  
      doc = Nokogiri::HTML5.parse(response.body)
      auth_token = doc.at('input[name="authenticity_token"]')['value']
  
      [cookie, auth_token]
    end
  
    def make_get_request_to_registration_page
      request = Net::HTTP::Get.new URI.join(@uri, '/users/sign_up')
      @http_client.request request
    end
  
    def build_params(auth_token, email, password)
      params = {
        'authenticity_token' => auth_token,
        'user[email]' => email,
        'user[password]' => password,
        'user[password_confirmation]' => password
      }
  
      URI.encode_www_form(params)
    end
  
    def create_http_client
      http = Net::HTTP.new(@uri.host, @uri.port)
      http.use_ssl = @uri.scheme == 'https'
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
  end
end
