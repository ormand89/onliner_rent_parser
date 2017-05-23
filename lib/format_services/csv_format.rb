require 'csv'

class CSVFormat < FormatService

  def write(apartments)
    CSV.open('myfile.csv', 'w') do |f|
      apartments.each { |apartment| apartment.description.to_a.each { |element| f << element } }
    end
  end
end
