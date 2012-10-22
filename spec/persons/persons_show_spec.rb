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

  subject { @res.header.code }

  it 'Не переданы ' do
    id = 4
    should == '404'
  end
end

describe 'Запрос ФЛ по существующему id.' do
  before do
    # @id = id = __('Необходимо задать существующий в системе person_id')
    @id = 1

    rq = RequestToExt.new("persons/#{@id}.xml")
    @doc = rq.get_xml()
  end

  subject { @doc.xpath('//person') }

  it 'Не переданы ' do
    should have_tag('id').with_value(@id)
  end
end
