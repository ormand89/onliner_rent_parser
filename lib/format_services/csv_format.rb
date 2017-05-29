require 'csv'

# Concrete realization of FormatService. It uses csv for help and compose our Apartments list to the needed format

class CSVFormat < FormatService
  # Controls the output path for file
  # @return [String] the path of the file

  attr_reader :path

  # @param output_path [String] the path of the file, `text`
  def initialize(output_path)
    @path = "#{output_path}/myfile.csv"
  end

  # Provides writing apartments to file
  # @param apartments [Array<Apartments>] the list of Apartments for building the file
  # @return [file] associated file with our list of Apartments
  def write(apartments)
    CSV.open(@path, 'w') do |f|
      apartments.each { |apartment| apartment.description.to_a.each { |element| f << element } }
    end
  end
end
