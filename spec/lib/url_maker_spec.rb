require 'spec_helper'
require 'url_maker'

RSpec.describe URLMaker do
  let(:flat_hash) {
    { :rent_type => ["room"],
      :price => { :min => "50", :max => "200" },
      :currency => "usd",
      :metro => ["red_line", "blue_line"],
      :bounds => { :lb=>{ :lat => 53.77865438306248, :long => 27.368307803348014},
          :rt => { :lat => 54.02541191840544, :long => 27.75637209747086}},
      :page=>1 } }

  subject(:url_maker) { described_class.new(flat_hash) }

  describe '#onliner_url' do
    let(:expected_url) { 'https://ak.api.onliner.by/search/apartments?bounds%5Blb%5D%5Blat%5D'\
                         '=53.77865438306248&bounds%5Blb%5D%5Blong%5D=27.368307803348014&bounds%5Brt%5D%5Blat%5D'\
                         '=54.02541191840544&bounds%5Brt%5D%5Blong%5D=27.75637209747086&currency=usd&metro%5B%5D='\
                         'red_line&metro%5B%5D=blue_line&page=1&price%5Bmax%5D=200&price%5Bmin%5D=50&rent_type%5B%5D=room' }

    it 'make onliner url using parameters' do
      expect(url_maker.onliner_url).to eql(expected_url)
    end
  end

  describe '#next_url' do
    let(:expected_next_url) { 'https://ak.api.onliner.by/search/apartments?bounds%5Blb%5D%5Blat%5D'\
                         '=53.77865438306248&bounds%5Blb%5D%5Blong%5D=27.368307803348014&bounds%5Brt%5D%5Blat%5D'\
                         '=54.02541191840544&bounds%5Brt%5D%5Blong%5D=27.75637209747086&currency=usd&metro%5B%5D='\
                         'red_line&metro%5B%5D=blue_line&page=2&price%5Bmax%5D=200&price%5Bmin%5D=50&rent_type%5B%5D=room' }

    it 'change page to next at onliner url' do
      expect(url_maker.next_url(flat_hash[:page])).to eql(expected_next_url)
    end
  end

  let(:url) { 'https://raw.githubusercontent.com/ormand89/onliner_rent_parser/master/spec/fixtures/apartments' }

  describe '#last_page' do
    it 'return correct page number' do
      expect(url_maker.last_page(url)).to eql(2)
    end
  end

    describe '#apartments_urls' do
    it 'return urls each apartment as array' do
      expect(url_maker.apartments_urls(url).size).to eql(36)
    end
  end
end
