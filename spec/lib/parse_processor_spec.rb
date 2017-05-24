require 'spec_helper'
require 'parse_processor'

RSpec.describe ParseProcessor do
  let(:flat_hash) {
    { :rent_type => ["room"],
      :price => { :min => "150", :max => "200" },
      :currency => "usd",
      :metro => ["red_line", "blue_line"],
      :bounds => { :lb=>{ :lat => 53.77865438306248, :long => 27.368307803348014},
          :rt => { :lat => 54.02541191840544, :long => 27.75637209747086}},
      :page=>1 } }

  subject(:parse_processor) { described_class.new(flat_hash) }

  describe '#apartments' do

    it 'make array of apartments using parameters' do
      expect(parse_processor.apartments.size).to be > 3
      expect(parse_processor.apartments[0].class).to eql(Apartments)
    end
  end
end
