require 'container'
require 'parse_processor'

class FormatBuilder
  def initialize(hash_options)
    #@format_service = Container.solve('json').new
    @parser_processor = ParseProcessor.new(hash_options)
  end

  def build
    @apartments ||= @parser_processor.parse
  end

  def sort
    @apartments.sort
  end

  def save
    @format_service.write(@apartments)
  end
end
