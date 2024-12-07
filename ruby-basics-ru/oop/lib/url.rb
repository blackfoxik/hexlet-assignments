# frozen_string_literal: true

require 'forwardable'
require 'uri'
# BEGIN
class Url 
  extend Forwardable
  include Comparable

  def_delegators :@uri, :scheme, :host, :port

  def initialize(link)
    @uri = URI(link)
    if link.split('?').count > 1
      @query_params = link.split('?').last.split('&').reduce({}) do |acc, raw_param|
                                                                   key = raw_param.split('=').first.to_sym
                                                                   value = raw_param.split('=').last
                                                                   acc[key] = value
                                                                   acc
                                                                 end
    else
      @query_params = {}
    end
  end

  def query_params
    @query_params
  end

  def query_param(key, default_value = nil)
    unless @query_params[key]
      return default_value
    end

    @query_params[key]
  end

  def <=>(other)
    [scheme, host, port, query_params] <=> [other.scheme, other.host, other.port, other.query_params]
  end
end
# END
