class FormatService
  def initialize(output_path)
    @path = output_path
  end

  def write(apartments)
    raise NotImplementedError
  end
end
