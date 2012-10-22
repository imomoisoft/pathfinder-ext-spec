# encoding: utf-8
require 'spec_helper'

describe 'Поиск людей по паспортным данным с пустымы поисковыми данными.' do
  before do
    rq = RequestToExt.new("persons.xml")
    @doc = rq.get_xml
    p @doc.xpath('//persons').to_s
  end

  subject { @doc.xpath('//person') }

  it 'Не переданы ' do
    # p '--------------------', @idx
    should have_tag('id').with_value(222)
  end
end
