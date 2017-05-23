require 'nokogiri'
require 'net/http'

class ApartmentBuilder
  DEFAULT_PARAMETERS = {
    price_byn: 'span.apartment-bar__price-value_primary',
    #price_usd: 'span.apartment-bar__price-value_complementary',
    flat_type: 'span.apartment-bar__value',  #[0]
    #owner: css('span.apartment-bar__value').text.strip, #[1]
    owner_name: 'div.apartment-info__sub-line_extended', #[2] gsub
    #phone: css('div.apartment-info__sub-line').text.strip,
    #all_features: css('div.apartment-options__item').text.strip,
    #lockeed_features: css('div.apartment-options__item_lack').text.strip,
    #flat_description: css('div.apartment-info__sub-line').text.strip, #[4] gsub
    #adress: css('div.apartment-info__sub-line').text.strip #[5]
  }.freeze

  FLAT_OPTIONS = {
    'Мебель' => true,
    'Кухонная мебель' => true,
    'Плита' => true,
    'Холодильник' => true,
    'Стиральная машина' => true,
    'Телевизор' => true,
    'Интернет' => true,
    'Лоджия или балкон' => true,
    'Кондиционер' => true
  }.freeze

  def build(url)
    @apartment = Nokogiri::HTML(Net::HTTP.get(URI(url)))
    apartment_options = {}
    apartment_options.merge!(DEFAULT_PARAMETERS)
    apartment_options.keys.each { |key| apartment_options[key] = @apartment.css(apartment_options[key]).text.strip }
    p apartment_options
    #Apartments.new(apartment_options)
  end
  
end
