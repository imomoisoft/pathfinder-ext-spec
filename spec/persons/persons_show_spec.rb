# encoding: utf-8
require 'spec_helper'

# @id = __('Заполни person_id в системе')

describe 'Запрос ФЛ по НЕ существующему id.' do
  before do
    # @id = id = __('Необходимо задать НЕ существующий в системе person_id')
    @id = 1111

    rq = RequestToExt.new("persons/#{@id}.xml")
    @res = rq.get()
  end

  subject { @res.code }

  it 'Статус 404 ' do
    should == '404'
  end
end

describe 'Запрос ФЛ по существующему id.' do
  before do
    # @id = id = __('Необходимо задать существующий в системе person_id')
    @id = 1

    rq = RequestToExt.new("persons/#{@id}.xml")
    @res = rq.get()
    @doc = rq.parse_xml(@res.body)
  end

  subject { @doc.xpath('//person') }

  it 'Найден тот же id' do
    should have_tag('id').with_value(@id)
  end

  it 'Статус 200' do
    @res.code.should == '200'
  end
end
