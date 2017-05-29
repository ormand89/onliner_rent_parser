# Provides common interface for writing Apartments to file
# @example
# class ConcreteFormat < FormatService
#
#   def write(apartments)

class FormatService

  # @param output_path [String] the output path for our file, `text`
  def initialize(output_path)
    @path = output_path
  end

  # Provides writing apartments to file
  # @param apartments [Array<Apartments>] the list of Apartments for building the file
  # @return [file] associated file with our list of Apartments
  def write(apartments)
    raise NotImplementedError
  end
end
