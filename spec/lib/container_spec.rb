require 'spec_helper'
require 'container'

RSpec.describe Container do
  describe '#parse_options' do
    shared_examples 'check parse order' do |input_format:, expected_output:|
      context "for move #{input_format}" do

        it 'return correct format service' do
          expect(Container.solve(input_format) ).to eql(expected_output)
        end
      end
    end

    include_examples 'check parse order', input_format: 'json', expected_output: JSONFormat
    include_examples 'check parse order', input_format: 'csv', expected_output: CSVFormat
  end
end
