require 'spec_helper'
require 'console_controller'

RSpec.describe OptionsParser do
  describe '#parse_options' do
    shared_examples 'check parse order' do |args:, rent_type:, price_min:, price_max:, metro:, only_owner:, sort:, format:|
      context "for options #{args}" do
        before { ARGV.push(*args) }
        subject(:console) { described_class.new }
        let(:options) { [tag, size, picture_number] }

        it 'return tag' do
          expect(console.parse_options ).to eql(options)
        end
      end
    end

    include_examples 'check parse order', args: ['--rent_type', 'pony', '--price_min', 'big'],
                                          tag: 'Pony', size: 'Big', picture_number: 10
    include_examples 'check parse order', args: ['--tag', 'tank', '--size', 'large'],
                                          tag: 'Tank', size: 'Large', picture_number: 10
    include_examples 'check parse order', args: ['--tag', 'Cats'],
                                          tag: 'Cats', size: 'Small', picture_number: 10
    include_examples 'check parse order', args: ['--tag', 'Flowers', '--size', 'big', '--quanity', '20'],
                                          tag: 'Flowers', size: 'Big', picture_number: 20
    include_examples 'check parse order', args: [],
                                          tag: 'Kitties', size: 'Small', picture_number: 10
  end
end
