# frozen_string_literal: true

require 'rack'

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    Rack::Runtime.new(@app).call(env)
  end
end
