require 'json'

class JSONFormat < FormatService

  def write(apartments)
    open('myfile.json', 'w') do |f|
      apartments.each { |apartment| f << apartment.description.to_json + "\n" }
    end
  end
end
