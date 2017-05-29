require 'net/http'
require 'active_support/core_ext/hash'
require 'json'

class URLMaker
  CONSTANT_URL = "https://ak.api.onliner.by/search/apartments?".freeze

  # @param apartments_options [Hash] input options in Hash
  def initialize(apartments_options)
    @options = apartments_options
  end

  # Make onliner main url using apartments_options.
  # @return [String] url for first onliner rent page.
  def onliner_url
    @url ||= (CONSTANT_URL + @options.to_query)
  end

  # Change page in onliner main url.
  # @param page_number [Integer] page number that we use to get next page number. We should iterate it by 1
  # @return [String] url for the next onliner rent page.
  def next_url(page_number)
    onliner_url.gsub(/page=\d{1,}/, "page=#{page_number + 1}")
  end

  # Find last page of onliner main url. For it parse page and get last page information
  # @param url [String]
  # @return [Integer] last page number
  def last_page(url = onliner_url)
    JSON(Net::HTTP.get(URI(url)))['page']['last']
    #Net::HTTP.get(URI(url)).scan(/\"last\"\:\d{1,}/).to_s.scan(/\d+/).first.to_i
  end

  # Find apartments urls and collect them into array. For it parse page and get each apartments url.
  # @param url [String]
  # @return [Array<String>] list of apartments urls.
  def apartments_urls(url)
    JSON(Net::HTTP.get(URI(url)))['apartments'].map { |value| value['url'] }
    #Net::HTTP.get(URI(url)).scan(/https\:\\\/\\\/r\S{10,}.s\\\/\d{4,7}/).map { |val| val.gsub("\\", "") }
  end
end
