class ParseProcessor
  def initialize(*args)
    @url_maker = URLMaker.new(*args)
    @html_opener = HTMLOpener.new
    @appartment_vuilder = AppartmentBuilder.new
  end

  def parse
    url = @url_maker.url
    max_pages = @html_opener.max_pages(url)

  end
end
