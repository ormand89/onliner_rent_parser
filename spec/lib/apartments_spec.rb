require 'spec_helper'
require 'apartments'

RSpec.describe Apartments do
  let(:first_apartment_description) { {
    'flat_type' => '1-комнатная квартира',
    'price_usd' => '200$',
    'price_byn' => '426,08р.',
    'owner' => 'Собственник',
    'owner_name' => 'Александр',
    'phone' => '+375 29 544-77-40',
    'adress' => 'Минск, улица Чичурина, 8',
    'flat_description'=> 'Сдаю 1-а комнатную квартиру, 2012 год постройки. 46/18/10. 10-й этаж.',
    'apartment_features' => {
      'Мебель' => true, 'Кухонная мебель' => true, 'Плита' => true, 'Холодильник' => true, 'Стиральная машина' => false,
      'Телевизор' => true, 'Интернет' => true, 'Лоджия или балкон' => true, 'Кондиционер' => false } } }

  let(:second_apartment_description) { {
    'flat_type' => '1-комнатная квартира',
    'price_usd' => '280$',
    'price_byn' => '426,08р.',
    'owner' => 'Собственник',
    'owner_name' => 'Александр',
    'phone' => '+375 29 544-77-40',
    'adress' => 'Минск, улица Чичурина, 8',
    'flat_description'=> 'Сдаю 1-а комнатную квартиру, 2012 год постройки. 46/18/10. 10-й этаж.',
    'apartment_features' => {
      'Мебель' => true, 'Кухонная мебель' => true, 'Плита' => true, 'Холодильник' => true, 'Стиральная машина' => false,
      'Телевизор' => true, 'Интернет' => true, 'Лоджия или балкон' => false, 'Кондиционер' => false } } }

  let(:first_apartments) { Apartments.new(first_apartment_description) }
  let(:second_apartments) { Apartments.new(second_apartment_description) }

  describe '#<=>' do
    it 'behaves like comparable' do
      expect(first_apartments <=> second_apartments ).to eq(-1)
      expect(second_apartments <=> first_apartments ).to eq(1)
      expect(first_apartments <=> first_apartments).to eq(0)
    end
  end
end
