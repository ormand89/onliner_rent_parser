require 'container'
require 'parse_processor'

class FormatBuilder
  def initialize(file_format, sort_option, file_path, apartments_options)
    @format_service = Container.solve(file_format).new(file_path)
    @parser_processor = ParseProcessor.new(apartments_options)
    @sort_option = sort_option
  end

  def build
    apartments
    sort
    save
  end

  private

  def apartments
    @apartments ||= @parser_processor.apartments
  end

  def sort
    @apartments.sort! if @sort_option
  end

  def save
    @format_service.write(@apartments)
  end
end
