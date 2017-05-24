require 'spec_helper'
require_relative 'format_service_spec'
require 'format_services/format_service'
require 'format_services/csv_format'

RSpec.describe CSVFormat do
  it_behaves_like 'format service'
end
