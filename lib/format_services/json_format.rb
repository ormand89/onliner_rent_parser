require 'json'

# Concrete realization of FormatService. It uses json for help and compose our Apartments list to the needed format

class JSONFormat < FormatService
  # Controls the output path for file
  # @return [String] the path of the file

  attr_reader :path

  # @param output_path [String] the path of the file, `text`
  def initialize(output_path)
    @path = "#{output_path}/myfile.json"
  end

  # Provides writing apartments to file
  # @param apartments [Array<Apartments>] the list of Apartments for building the file
  # @return [file] associated file with our list of Apartments
  def write(apartments)
    open(@path, 'w') do |f|
      apartments.each { |apartment| f << apartment.description.to_json + "\n" }
    end
  end
end
