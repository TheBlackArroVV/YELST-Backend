# frozen_string_literal: true

require 'roda'
require_relative 'contexts/**/*'

class App < Roda
  plugin :hash_routes

  Unreloader.require('routes') {}

  route do |r|
    r.hash_routes('')
  end
end
