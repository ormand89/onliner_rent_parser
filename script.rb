$LOAD_PATH.unshift(File.expand_path('../lib',__FILE__))

require 'console_controller'
require 'pry'

ConsoleController.new.call

