# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    prev_response = @app.call(env)
    status, headers, prev_body = prev_response

    return prev_response if status != 200

    hash = Digest::SHA256.hexdigest(prev_body.join)
    next_body = prev_body.push(hash.to_s)
    [status, headers, next_body]
  end
end
