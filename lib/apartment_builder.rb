require 'nokogiri'
require 'net/http'
require 'apartments'

class ApartmentBuilder
  APARTMENT_DESCRIPTION = {
    'flat_type' => :flat_type,
    'price_usd' => :price_usd,
    'price_byn' => :price_byn,
    'owner' => :owner,
    'owner_name' => :owner_name,
    'phone' => :phone,
    'adress' => :adress,
    'flat_description'=> :flat_description }.freeze

  APARTMENT_FEATURES = {
    'Мебель' => true,
    'Кухонная мебель' => true,
    'Плита' => true,
    'Холодильник' => true,
    'Стиральная машина' => true,
    'Телевизор' => true,
    'Интернет' => true,
    'Лоджия или балкон' => true,
    'Кондиционер' => true }.freeze

  # Build Apartments using their description and features. Get HTML, then parse it and collect parameters.
  # @param apartment_url [String] url of our future Apartments
  # @return [Apartments]
  def build(apartment_url)
    @apartment = Nokogiri::HTML(Net::HTTP.get(URI(apartment_url)))
    description = apartment_description
    features = apartment_features
    description['apartment_features'] = features
    Apartments.new(description)
  end

  private

  # Makes common apartments description. Hash, based on constant APARTMENT_DESCRIPTION, first merge it, then find unique description
  # @return [Hash] hash
  def apartment_description
    apartment_description = {}
    apartment_description.merge!(APARTMENT_DESCRIPTION)
    apartment_description.keys.each { |key| apartment_description[key] = send(apartment_description[key]) }
    apartment_description
  end

  # Makes common apartments features. Hash, based on constant APARTMENT_FEATURES, first merge it, then find unique features
  # @return [Hash] hash
  def apartment_features
    apartment_features = {}
    apartment_features.merge!(APARTMENT_FEATURES)
    features_unavailable.each { |feature| apartment_features[feature] = false }
    apartment_features
  end

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
    @apartment.css('div.apartment-info__sub-line')[0].text.strip.gsub("\n", ", ").gsub(/\s{2,}/, "")
  end

  def flat_description
    @apartment.css('div.apartment-info__sub-line')[4].text.strip.gsub("\n", "")
  end

  def adress
    @apartment.css('div.apartment-info__sub-line')[5].text.strip
  end

  def features_unavailable
    @apartment.css('div.apartment-options__item_lack').text.strip.split(/(?=\p{Lu})/)
  end
end
