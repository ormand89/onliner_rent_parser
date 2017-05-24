require 'container'
require 'parse_processor'

class FormatBuilder
  def initialize(file_format, sort_option, file_path, apartments_options)
    @format_service = Container.solve(file_format).new(file_path)
    @parser_processor = ParseProcessor.new(apartments_options)
    @sort_option = sort_option
  end

  def build
    @apartments ||= @parser_processor.apartments
    @apartments.sort! if @sort_option
    save(@apartments)
  end

  private

  def sort
    @apartments.sort
  end

  def save(apartments)
    @format_service.write(apartments)
  end
end
