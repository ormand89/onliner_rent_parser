require 'url_maker'
require 'apartment_builder'

class ParseProcessor
  def initialize(hash_options)
    @url_maker = URLMaker.new(hash_options)
    @appartment_builder = ApartmentBuilder.new
  end

  def parse
    url = @url_maker.onliner_url
    apartment_urls = []
    max_page = @url_maker.max_pages
    1.upto(max_page) do |page_number|
      apartment_urls.push(@url_maker.apartments_urls(url))
      url = @url_maker.next_url(page_number)
    end
    apartment_urls.flatten!

    apartments = []
    apartment_urls.each { |apartment| apartments.push(@appartment_builder.build(apartment)) }
    apartments
  end
end
