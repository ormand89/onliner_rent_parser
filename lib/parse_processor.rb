require 'url_maker'
require 'apartment_builder'
require 'thread'

class ParseProcessor
  THREAD_COUNT = 12

  def initialize(apartments_options)
    @url_maker = URLMaker.new(apartments_options)
  end

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
