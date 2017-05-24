require 'optparse'
require 'format_builder'

class ConsoleController
  CONSTANT_URL = "https://ak.api.onliner.by/search/apartments?".freeze

  def initialize
    @options = OptionsParser.new.parse_options
  end

  def call
    FormatBuilder.new(@options.file_format, @options.sort_option, @options.apartments_parameters).build
  end
end

class OptionsParser
  FILE_FORMAT = 'json'.freeze
  SORT_OPTIONS = false
  DEFAULT_ARGS = {
    rent_type: ['room', '1_room', '2_rooms', '3_rooms', '4_rooms', '5_rooms', '6_rooms'],
    price: { min: 50,
             max: 8500 },
    currency: 'usd',
    metro: ['red_line', 'blue_line'],
    bounds: { lb: { lat: 53.77865438306248,
                    long: 27.368307803348014 },
              rt: { lat: 54.02541191840544,
                    long: 27.75637209747086 } },
    page: 1 }.freeze

  def parse_options
    file_format, sort_option = FILE_FORMAT, SORT_OPTIONS
    flat_parameters = {}
    flat_parameters.merge!(DEFAULT_ARGS)
    OptionParser.new do|opts|
      opts.banner = "Usage: script.rb [options]"
      opts.on('-rRENT_TYPE', '--rent_type RENT_TYPE', Array) { |rooms| flat_parameters[:rent_type] = rooms }
      opts.on('--price_min PRICE_MIN', String) { |price_min| flat_parameters[:price][:min] = price_min }
      opts.on('--price_max PRICE_MAX', String) { |price_max| flat_parameters[:price][:max] = price_max }
      opts.on('-mMETRO', '--metro METRO', Array) { |value| flat_parameters[:metro] = value }
      opts.on('-oOWNER', '--owner OWNER', String) { |value| flat_parameters[:only_owner] = value }
      opts.on('-sSORT', '--sort SORT') { |sort| sort_option = sort.downcase }
      opts.on('-fFORMAT', '--file_format FORMAT') { |value| file_format = value.downcase }
    end.parse!
    Options.new(file_format, sort_option, flat_parameters)
  end
end

class Options
  attr_reader :file_format, :sort_option, :apartments_parameters

  def initialize(file_format, sort_option, apartments_parameters)
    @file_format = file_format
    @sort_option = sort_option
    @apartments_parameters = apartments_parameters
  end
end
