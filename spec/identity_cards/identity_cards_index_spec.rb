# encoding: utf-8
require 'spec_helper'

describe 'Запрос информации о документах удостоверяющих личность.', :broken => false do

  let(:person_id) { 1 }
  # let(:person_id) { __('Необходимо задать существующий в системе person_id') }
  let(:identity_cards_count) { 3 }

  before do
    rq = RequestToExt.new("persons/#{person_id}/identity_cards.xml")
    @doc = rq.get_xml
  end

  subject { @doc.xpath('//identity_cards') }

  context 'Проверка информации о найденом количестве записей, количестве страниц и текущей старницы' do
    it 'Количество страниц == 0' do
      should have_tag('pages/total_pages').with_value(1)
    end

    it 'Общее количество объектов == 3' do
      should have_tag('pages/total_objects').with_value(3)
    end

    it 'Номер текущей страницы == 1' do
      should have_tag('pages/current_page').with_value(1)
    end
  end
end
