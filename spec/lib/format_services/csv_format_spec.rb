require 'spec_helper'
require_relative 'format_service_spec'
require 'format_service/csv_format'

RSpec.describe CSVFormat do
  it_behaves_like 'format service'
end
