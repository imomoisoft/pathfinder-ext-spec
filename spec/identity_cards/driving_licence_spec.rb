# encoding: utf-8
require 'spec_helper'

describe 'Запрос информации о документах удостоверяющих личность.', :broken => false do
  let(:person_id) { __('Необходимо задать существующий в системе person_id') }
  let(:identity_cards_count) { __('Необходимо задать количестов возвращаемых документов') }
  let(:true_serie) { __('Необходимо задать серию') }
  let(:true_number) { __('Необходимо задать номер') }

  let(:true_first_name) { __('Необходимо задать имя') }
  let(:true_last_name) { __('Необходимо задать фамилию') }
  let(:true_middle_name) { __('Необходимо задать отчество') }

  let(:true_first_name_latin) { __('Необходимо задать имя латинскими буквами') }
  let(:true_last_name_latin) { __('Необходимо задать фамилию латинскими буквами') }

  let(:true_issue_date) { __('Необходимо задать дату выдачи') }
  let(:true_issuer) { __('Необходимо задать кем выдан') }
  let(:true_issuer_code) { __('Необходимо задать код-подразделения') }
  let(:true_issuer_region_code) { __('Необходимо задать КЛАДР-код подразделения выдачи') }

  let(:true_reason) { __('Необходимо задать причину выдачи') }
  let(:true_state) { __('Необходимо задать статус документа') }
  let(:true_sex_title) { __('Необходимо задать пол') }
  let(:true_birth_place) { __('Необходимо задать дату рождения') }

  # Пример инициализации переменных
  #
  # let(:person_id) { 1 }
  # let(:identity_cards_count) { 3 }
  # let(:true_serie) { '7200' }
  # let(:true_number) { '900200' }

  # let(:true_first_name) { 'Георгий' }
  # let(:true_last_name) { 'Фрунзе' }
  # let(:true_middle_name) { 'Васильевич' }

  # let(:true_first_name_latin) { 'Georgiy' }
  # let(:true_last_name_latin) { 'Frunze' }

  # let(:true_issue_date) { DateTime.new(2011, 5, 11) }
  # let(:true_issuer) { 'Организация выдающая водительские удостоверения' }
  # let(:true_issuer_code) { '12345' }
  # let(:true_issuer_region_code) { '770000000000' }

  # let(:true_reason) { 'Причина выдачи документа' }
  # let(:true_state) { 'Текущий статус документа' }
  # let(:true_sex_title) { 'М' }
  # let(:true_birth_place) { 'Место рождения гражданина РФ' }

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

  context 'Информация об заграничном паспорте гражданина РФ' do
    subject { @doc.xpath('//identity_cards/driving_licence[1]') }

    # 'Правильное имя'
    it { should have_tag('first_name').with_value(true_first_name) }
    # 'Правильная фамилия'
    it { should have_tag('last_name').with_value(true_last_name) }
    # 'Правильное отчество'
    it { should have_tag('middle_name').with_value(true_middle_name) }

    it { should have_tag('first_name_latin').with_value(true_first_name_latin) }
    it { should have_tag('last_name_latin').with_value(true_last_name_latin) }

    it { should have_tag('person_id').with_value(person_id) }
    it { should have_tag('number').with_value(true_number) }
    it { should have_tag('serie').with_value(true_serie) }

    it { should have_tag('issue_date').with_value(I18n.l(true_issue_date, :format => :xml)) }
    it { should have_tag('issuer').with_value(true_issuer) }
    it { should have_tag('issuer_code').with_value(true_issuer_code) }
    it { should have_tag('region/code').with_value(true_issuer_region_code) }

    it { should have_tag('reason').with_value(true_reason) }
    it { should have_tag('state').with_value(true_state) }
    it { should have_tag('birth_place').with_value(true_birth_place) }
  end
end
