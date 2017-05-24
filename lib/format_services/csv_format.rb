require 'csv'

class CSVFormat < FormatService
  attr_reader :path

  def initialize(output_path)
    @path = "#{output_path}/myfile.csv"
  end

  def write(apartments)
    CSV.open(@path, 'w') do |f|
      apartments.each { |apartment| apartment.description.to_a.each { |element| f << element } }
    end
  end
end
