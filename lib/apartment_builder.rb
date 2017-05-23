require 'nokogiri'
require 'net/http'
require 'apartments'

class ApartmentBuilder
  APARTMENT_DESCRIPTION = {
    'price_byn' => :price_byn,
    'price_usd' => :price_usd,
    'flat_type' => :flat_type,
    'owner' => :owner,
    'owner_name' => :owner_name,
    'phone' => :phone,
    'flat_description'=> :flat_description,
    'adress' => :adress
     }.freeze

  APARTMENT_FEATURES = {
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

    apartment_description = {}
    apartment_description.merge!(APARTMENT_DESCRIPTION)
    apartment_description.keys.each { |key| apartment_description[key] = send(apartment_description[key]) }

    apartment_features = {}
    apartment_features.merge!(APARTMENT_FEATURES)
    features_unavailable.each { |feature| apartment_features[feature] = false }

    apartment_description.merge!(apartment_features)
    Apartments.new(apartment_description)
  end

  private

  def price_byn
    @apartment.css('span.apartment-bar__price-value_primary').text.strip.gsub(/\s/, "")
  end

  def price_usd
    @apartment.css('span.apartment-bar__price-value_complementary').text.strip.gsub(/\s/, "")
  end

  def flat_type
    @apartment.css('span.apartment-bar__value')[0].text.strip
  end

  def owner
    @apartment.css('span.apartment-bar__value')[1].text.strip
  end

  def owner_name
    @apartment.css('div.apartment-info__sub-line_extended')[2].text.strip
  end

  def phone
    @apartment.css('div.apartment-info__sub-line')[0].text.strip
  end

  def flat_description
    @apartment.css('div.apartment-info__sub-line')[4].text.strip
  end

  def adress
    @apartment.css('div.apartment-info__sub-line')[5].text.strip
  end

  def features_unavailable
    @apartment.css('div.apartment-options__item_lack').text.strip.split(/(?=\p{Lu})/)
  end
end
