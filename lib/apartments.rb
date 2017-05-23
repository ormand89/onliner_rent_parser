class Apartments
  #include comparable

  attr_reader :description

  def initialize(hash_description)
    @description = hash_description
  end

  #def <=>(other_apartment)
    #self.description <=> other_apartment.description
  #end
end
