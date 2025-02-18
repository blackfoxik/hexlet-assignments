# frozen_string_literal: true

class AdminPolicy
  def initialize(app)
    @app = app
  end

  def call(env)
    failure = [403, { 'Content-Type' => 'text/html' }, ['403 Forbidden']]
    request = Rack::Request.new(env)
    return failure if request.path.include?('admin')

    @app.call(env)
  end
end
