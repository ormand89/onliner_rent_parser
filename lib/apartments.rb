class Apartments
  include Comparable

  attr_reader :description

  def initialize(hash_description)
    @description = hash_description
  end

  def <=>(other_apartment)
    self_features_counter = description['apartment_features'].values.select { |v| v }.count
    other_feature_counter = other_apartment.description['apartment_features'].values.select { |v| v }.count
    self_advantage = feature_divider(description['price_usd'].gsub("$", "").to_i, self_features_counter)
    other_advantage = feature_divider(other_apartment.description['price_usd'].gsub("$", "").to_i, other_feature_counter)
    self_advantage <=> other_advantage
  end

  private

  def feature_divider(price, features_number)
    if features_number.zero?
      price
    else
      price / features_number
    end
  end
end
