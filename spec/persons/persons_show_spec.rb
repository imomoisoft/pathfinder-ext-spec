# encoding: utf-8
require 'spec_helper'

# @id = __('Заполни person_id в системе')
# @server =

describe 'Запрос ФЛ по НЕ существующему id.' do
  let(:server) { 'http://localhost:3000' }

  before do
    @id = 1111

    path = '%s/persons/%s.xml' % [server, @id]
    uri = URI(path)
    @res = Net::HTTP.get_response(uri)

    # @doc = Nokogiri::XML(res.header.code)
  end

  subject { @res.header.code }
  # subject { @doc.xpath('//person') }

  it 'Не переданы ' do
    id = 4
    should == '404'
  end
end


describe 'Запрос ФЛ по существующему id.' do
  let(:server) { 'http://localhost:3000' }

  before do
    @id = 1
    path = '%s/persons/%s.xml' % [server, @id]
    uri = URI(path)
    res = Net::HTTP.get_response(uri)


    @doc = Nokogiri::XML(res.body)
  end

  subject { @doc.xpath('//person') }

  it 'Не переданы ' do
    id = 4
    should have_tag('id').with_value(@id)
  end
end
