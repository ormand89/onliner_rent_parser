require 'spec_helper'
require_relative 'format_service_spec'
require 'format_services/format_service'
require 'format_services/json_format'


RSpec.describe JSONFormat do
  it_behaves_like 'format service'
end
