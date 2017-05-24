require 'spec_helper'
require 'apartments'

OUTPUT_PATH = File.expand_path("../../fixtures", File.dirname(__FILE__))

RSpec.shared_examples 'format service' do
  describe '#write' do
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

    let(:apartment) { [Apartments.new(description)] }
    subject(:service) { described_class.new(OUTPUT_PATH) }
    let(:file_writer) { service.write(apartment) }
    let(:service_path) { service.path }

    it "return file in correct format" do
      expect(file_writer.size).to eq(1)
      expect(service_path.size).to be > 10
    end
  end
end
