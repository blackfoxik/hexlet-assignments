# frozen_string_literal: true

require 'rack'

class Router
  def call(env)
    responses_for_paths = { '/' => [200, { 'Content-Type' => 'text/html' }, ['Hello, World!']],
                            '/about' => [200, { 'Content-Type' => 'text/html' }, ['About page']] }

    failure = [404, { 'Content-Type' => 'text/html' }, ['404 Not Found']]
    request = Rack::Request.new(env)

    return responses_for_paths[request.path] if responses_for_paths.key?(request.path)

    failure
  end
end
