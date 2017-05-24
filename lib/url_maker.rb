require 'net/http'
require 'active_support/core_ext/hash'
require 'json'

class URLMaker
  CONSTANT_URL = "https://ak.api.onliner.by/search/apartments?".freeze

  def initialize(apartments_options)
    @options = apartments_options
  end

  def onliner_url
    @url ||= (CONSTANT_URL + @options.to_query)
  end

  def next_url(page_number)
    onliner_url.gsub(/page=\d{1,}/, "page=#{page_number + 1}")
  end

  def last_page(url = nil)
    JSON(Net::HTTP.get(URI(onliner_url)))['page']['last']
    #Net::HTTP.get(URI(onliner_url)).scan(/\"last\"\:\d{1,}/).to_s.scan(/\d+/).first.to_i
  end

  def apartments_urls(url)
    JSON(Net::HTTP.get(URI(url)))['apartments'].map { |value| value['url'] }
    #Net::HTTP.get(URI(url)).scan(/https\:\\\/\\\/r\S{10,}.s\\\/\d{4,7}/).map { |val| val.gsub("\\", "") }
  end
end
