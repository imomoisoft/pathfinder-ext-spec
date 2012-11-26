# encoding: utf-8
require 'spec_helper'

describe 'Тестирование реализации сервиса get /persons.xml', :broken => false do

  describe 'Получение идентификатора поиска' do
    before do
      rq = RequestToExt.new('persons.xml')
      @doc = rq.get_xml
    end

    it 'Идентификатор получен' do
      @doc.should have_tag('search_id') #.xpath('//')
    end

  end

  # describe 'Поиск людей по паспортным данным с пустыми поисковыми данными.' do
  #   before do
  #     rq = RequestToExt.new("persons.xml")
  #     @doc = rq.get_xml
  #     # p @doc.xpath('//persons/pages/total_pages').to_s
  #   end

  #   subject { @doc.xpath('//persons') }

  #   context 'Проверка информации о найденом количестве записей, количестве страниц и текущей старницы' do
  #     it 'Количество страниц == 0' do
  #       subject.should have_tag('pages/total_pages').with_value(0)
  #     end

  #     it 'Общее количество объектов == 0' do
  #       subject.should have_tag('pages/total_objects').with_value(0)
  #     end

  #     it 'Номер текущей страницы == 1' do
  #       subject.should have_tag('pages/current_page').with_value(1)
  #     end
  #   end
  # end

  # describe 'Поиск людей по паспортным данным по ФИО.' do
  #   before do
  #     @last_name = 'Фрунзе'
  #     @finded_id = 1

  #     rq = RequestToExt.new("persons.xml")
  #     @doc = rq.get_xml({'basic[last_name]' => @last_name})
  #   end

  #   subject { @doc.xpath('//persons') }

  #   context 'Проверка информации о найденом количестве записей, количестве страниц и текущей страницею' do
  #     it 'Количество страниц == 1' do
  #       subject.should have_tag('pages/total_pages').with_value(1)
  #     end

  #     it 'Общее количество объектов == 1' do
  #       subject.should have_tag('pages/total_objects').with_value(1)
  #     end

  #     it 'Номер текущей страницы == 1' do
  #       subject.should have_tag('pages/current_page').with_value(1)
  #     end
  #   end

  #   context 'Проверка результатов' do
  #     it 'Найденный id == 3' do
  #       @doc.should have_tag('//persons/person[1]/id').with_value(@finded_id)
  #     end
  #   end
  # end
end
