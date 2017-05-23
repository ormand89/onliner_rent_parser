class Apartments
  include comparable

  def <=>(other_apartment)
    self.features <=> other_apartment.features
  end
end
