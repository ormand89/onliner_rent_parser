require 'json'

class JSONFormat < FormatService
  attr_reader :path

  def initialize(output_path)
    @path = "#{output_path}/myfile.json"
  end

  def write(apartments)
    open(@path, 'w') do |f|
      apartments.each { |apartment| f << apartment.description.to_json + "\n" }
    end
  end
end
