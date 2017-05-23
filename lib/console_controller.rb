require 'optparse'
require 'format_builder'

class ConsoleController
  CONSTANT_URL = "https://ak.api.onliner.by/search/apartments?".freeze
  def initialize
    @options = OptionsParser.new.parse_options
  end

  def call
    @format_builder = FormatBuilder.new(@options)
    @format_builder.build
    #@format_builder.sort if sort
    #@format_builder.save
  end
end

class OptionsParser
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
    parameters = {}
    parameters.merge!(DEFAULT_ARGS)
    OptionParser.new do|opts|
      opts.banner = "Usage: script.rb [options]"
      opts.on('-rRENT_TYPE', '--rent_type RENT_TYPE', Array) { |rooms| parameters[:rent_type] = rooms }
      opts.on('--price_min PRICE_MIN', String) { |price_min| parameters[:price][:min] = price_min }
      opts.on('--price_max PRICE_MAX', String) { |price_max| parameters[:price][:max] = price_max }
      opts.on('-mMETRO', '--metro METRO', Array) { |value| parameters[:metro] = value }
      opts.on('-oOWNER', '--owner OWNER', String) { |value| parameters[:only_owner] = value }
    end.parse!
    parameters
  end
end


