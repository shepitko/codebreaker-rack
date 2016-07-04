
require 'rack'
require_relative 'lib/application'

use Rack::Static, root: 'public', urls: ['/images', '/js', '/css', '/font']

run Application