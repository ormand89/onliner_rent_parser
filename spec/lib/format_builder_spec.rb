require 'spec_helper'
require 'format_builder'

RSpec.describe FormatBuilder do
  let(:apartments_options) {
    { rent_type: ['room', '1_room'],
      price: { min: 150, max: 190 },
      currency: 'usd',
      metro: ['red_line', 'blue_line'],
      bounds: { lb: { lat: 53.77865438306248, long: 27.368307803348014 },
                rt: { lat: 54.02541191840544, long: 27.75637209747086 } },
      page: 1 } }
  let(:path) { File.expand_path("../fixtures", File.dirname(__FILE__)) }
  let(:format) { 'json' }
  let(:sort) { 'true' }
  subject(:builder) { described_class.new(format, sort, path, apartments_options) }

  describe '#build' do
    it 'return apartments in json format' do
      expect(builder.build.size ).to be > 5
      expect(File.file?("#{path}/myfile.json")).to eq (true)
    end
  end
end
