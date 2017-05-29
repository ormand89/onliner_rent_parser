require 'url_maker'
require 'apartment_builder'
require 'thread'

class ParseProcessor
  THREAD_COUNT = 12

  # @param apartments_options [Hash] input options in Hash
  def initialize(apartments_options)
    @url_maker = URLMaker.new(apartments_options)
  end

  # Make list of Apartments. Go each apartments url from list and make Apartments. Collect each Apartments to array.
  # @return [Array<Apartments>] list of Apartments.
  def apartments
    flat_urls = apartment_urls(onliner_main_urls)
    apartments = []
    mutex = Mutex.new
    THREAD_COUNT.times.map {
      Thread.new(flat_urls, apartments) do |flat_urls, apartments|
        while url = mutex.synchronize { flat_urls.pop }
          apartment = ApartmentBuilder.new.build(url)
          mutex.synchronize { apartments << apartment }
        end
      end
    }.each(&:join)
    apartments
  end

  private

  # Get all onliner rent urls using our input options.
  # @return [Array<String>] list of our urls.
  def onliner_main_urls
    urls = []
    (@url_maker.last_page).times do |page_number|
      urls.push(@url_maker.next_url(page_number))
    end
    urls
  end

  # Make apartments urls for each flat from main onliner rent urls list.
  # @param onliner_urls [Array<String>] list of our urls.
  # @return [Array<String>] list of apartments urls.
  def apartment_urls(onliner_urls)
    urls = []
    onliner_urls.each do |page|
      urls.push(@url_maker.apartments_urls(page))
    end
    urls.flatten!
  end
end
