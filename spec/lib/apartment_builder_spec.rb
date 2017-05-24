require 'spec_helper'
require 'apartment_builder'

RSpec.describe ApartmentBuilder do

  let(:url) { 'https://github.com/ormand89/onliner_rent_parser/blob/master/spec/fixtures/flat.html' }

  let(:description) { {
    'flat_type' => '2-комнатная квартира',
    'price_usd' => '200$',
    'price_byn' => '370,48р.',
    'owner' => 'Агент',
    'owner_name' => 'Марина',
    'phone' => '+375 29 631-95-55',
    'adress' => '2-х ком.кв (Зеленый Луг)ул Гамарника д 1.',
    'flat_description'=> 'Аккуратная 2-х ком.кв (Зеленый Луг)ул Гамарника д 1.'\
                         'Стеклопакеты,металическая дверь,вся мебель,стиральная машина,холодильник.'\
                         'Не евро,но после косм.ремонта.Прописан 1 человек.',
    'apartment_features' => {
      'Мебель' => true,
      'Кухонная мебель' => true,
      'Плита' => true,
      'Холодильник' => true,
      'Стиральная машина' => true,
      'Телевизор' => true,
      'Интернет' => false,
      'Лоджия или балкон' => true,
      'Кондиционер' => false } } }

  subject(:apartment_builder) { described_class.new }
  let(:apartment) { subject.build(url) }

  describe '#build' do

    it 'make apartment using url' do
      expect(apartment.class).to eql(Apartments)
      expect(apartment.description).to eql(description)

    end
  end
end
