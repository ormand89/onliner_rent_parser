require 'format_services/format_service'
require 'format_services/csv_format'
require 'format_services/json_format'

class Container
  class << self
    def register(key, value)
      unless storage.has_key?(key)
        storage[key] = value
      end
    end

    def solve(key)
      storage[key]
    end

    def storage
      @storage ||= {}
    end
  end
end

Container.register('csv', CSVFormat)
Container.register('json', JSONFormat)
