# frozen_string_literal: true

require 'roda'
require 'pry'
require 'json'
require 'bcrypt'
require 'jwt'
require 'securerandom'

Unreloader.require 'database'
Unreloader.require '../contexts/record'
Dir[File.join(__dir__, '../contexts/**', '*.rb')].reject do |s|
  s.end_with?('routes.rb')
end.sort.each { |file| Unreloader.require file }

class App < Roda
  plugin :hash_routes

  Unreloader.require('contexts/users/routes.rb') {}

  route do |r|
    r.hash_routes('')
  end
end
