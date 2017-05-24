require 'spec_helper'
require 'apartment_builder'

RSpec.describe ApartmentBuilder do

  let(:url) { 'https://raw.githubusercontent.com/ormand89/onliner_rent_parser/master/spec/fixtures/flat.html' }
  let(:description) { {
    'flat_type' => '1-комнатная квартира',
    'price_usd' => '230$',
    'price_byn' => '426,08р.',
    'owner' => 'Собственник',
    'owner_name' => 'Александр',
    'phone' => '+375 29 544-77-40',
    'adress' => 'Минск, улица Чичурина, 8',
    'flat_description'=> 'Сдаю 1-а комнатную квартиру, 2012 год постройки. 46/18/10. 10-й этаж.'\
                         ' Встроенные шкафы коридор и комната. Полность кухня, с холодильником.'\
                         ' Горка в комнате. Сан/узлы плитка. Лоджия большая, обитания вагонкой.'\
                         ' Входная дверь металлическая, хорошего качества. До метро 10 мин. пешком или 4 остановки.'\
                         ' Цена договорная, на длительный срок, не студентам. 8 (029) 544-77-40.',
    'apartment_features' => {
      'Мебель' => true,
      'Кухонная мебель' => true,
      'Плита' => true,
      'Холодильник' => true,
      'Стиральная машина' => false,
      'Телевизор' => true,
      'Интернет' => true,
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
