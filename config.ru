require 'sinatra'
require 'sinatra/reloader'
require 'nokogiri'
require_relative './models/authority'
require_relative './controllers/authorities_controller'
require_relative './lib/fsaapi'

use Rack::Reloader

use Rack::MethodOverride

run AuthoritiesController