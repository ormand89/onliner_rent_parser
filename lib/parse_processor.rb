require 'url_maker'
require 'apartment_builder'

class ParseProcessor
  def initialize(apartments_options)
    @url_maker = URLMaker.new(apartments_options)
    @appartment_builder = ApartmentBuilder.new
  end

  def apartments
    flat_urls = apartment_urls(onliner_main_urls)
    apartments = []
    flat_urls.each { |flat| apartments.push(@appartment_builder.build(flat)) }
    apartments
  end

  private

  def onliner_main_urls
    urls = []
    (@url_maker.last_page).times do |page_number|
      urls.push(@url_maker.next_url(page_number))
    end
    urls
  end

  def apartment_urls(onliner_urls)
    urls = []
    onliner_urls.each do |page|
      urls.push(@url_maker.apartments_urls(page))
    end
    urls.flatten!
  end
end
