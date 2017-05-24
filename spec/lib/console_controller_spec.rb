require 'spec_helper'
require 'console_controller'

OUTPUT_PATH = File.expand_path("spec/fixtures", File.dirname(__FILE__))

RSpec.describe OptionsParser do
  describe '#parse_options' do
    shared_examples 'check parse order' do |args:, rent:, price_min:, price_max:, underground:, owner:, sort:, format:|
      context "for options #{args}" do
        before { ARGV.push(*args) }
        subject(:console) { described_class.new }
        let(:flat_hash) {
          { rent_type: rent,
            price: { min: price_min, max: price_max },
            currency: 'usd',
            metro: underground,
            bounds: { lb: { lat: 53.77865438306248, long: 27.368307803348014 },
                      rt: { lat: 54.02541191840544, long: 27.75637209747086 } },
            page: 1 } }
        let(:options) { Options.new(format, sort, OUTPUT_PATH, flat_hash) }
        let(:parsed_options) { console.parse_options }

        it 'return correct options' do
          expect(parsed_options.apartments_parameters ).to eq(options.apartments_parameters)
          expect(parsed_options.sort_option ).to eq(options.sort_option)
          expect(parsed_options.file_format ).to eq(options.file_format)
        end
      end
    end

    include_examples 'check parse order',
      args: ['--rent_type', 'room,1_room', '--price_min', '100', '--price_max', '500'],
      rent: ['room', '1_room'],
      price_min: '100',
      price_max: '500',
      format: 'json',
      sort: false,
      underground: ['red_line', 'blue_line'],
      owner: false

    include_examples 'check parse order',
      args: ['--rent_type', '2_room', '--price_min', '50', '--price_max', '400', '--file_format', 'csv'],
      rent: ['2_room'],
      price_min: '50',
      price_max: '400',
      format: 'csv',
      sort: false,
      underground: ['red_line', 'blue_line'],
      owner: false

    include_examples 'check parse order',
      args: ['--price_min', '300', '--price_max', '700', '--sort', 'true', '--metro', 'red_line' ],
      rent: ['room', '1_room', '2_rooms', '3_rooms', '4_rooms', '5_rooms', '6_rooms'],
      price_min: '300',
      price_max: '700',
      format: 'json',
      sort: 'true',
      underground: ['red_line'],
      owner: false
  end
end
