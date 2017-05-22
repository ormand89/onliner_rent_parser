require 'container'

class FormatBuilder
  def initialize(format, *args)
    @format_service = Container.solve.new(format)
    @parser_processor = ParseProcessor.new(*args)
  end

  def build
    @parser_processor
  end
end
