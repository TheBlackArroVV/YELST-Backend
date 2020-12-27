# frozen_string_literal: true

dev = ENV['RACK_ENV'] == 'development'

require 'rack/unreloader'
require 'rack/cors'

Unreloader = Rack::Unreloader.new(subclasses: %w[Roda], reload: dev) { App }
Unreloader.require('app.rb') { 'App' }
run(dev ? Unreloader : App.freeze.app)

use Rack::Cors do
  allow do
    origins '*'
    resource '*',
             headers: :any,
             methods: %i[get post delete put patch options head]
  end
end
