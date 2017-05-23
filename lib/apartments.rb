class Apartments
  include Comparable

  attr_reader :description

  def initialize(hash_description)
    @description = hash_description
  end

  def <=>(other_apartment)
    self_features_counter = 0
    self.description['apartment_features'].each { |_, value| self_features_counter += 1 if value }
    other_feature_counter = 0
    other_apartment.description['apartment_features'].each { |_, value| other_feature_counter += 1 if value }
    self_advantage = feature_divider(self.description['price_usd'].gsub("$", "").to_i, self_features_counter)
    other_advantage = feature_divider(other_apartment.description['price_usd'].gsub("$", "").to_i, other_feature_counter)
    self_advantage <=> other_advantage
  end

  private

  def feature_divider(price, features_number)
    price / features_number
    rescue ZeroDivisionError
    price / 1
  end
end
