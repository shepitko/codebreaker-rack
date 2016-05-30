
require 'rack'
require_relative 'lib/application'

use Rack::Static, root: 'public', urls: ['/images', '/js', '/css', '/font', '/fonts/roboto']
use Rack::Reloader, 0

run Application