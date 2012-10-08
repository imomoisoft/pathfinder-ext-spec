# encoding: utf-8
require 'spec_helper'

describe 'Поиск ФЛ по паспортным данным с неправильными поисковыми данными.' do
  let(:server) { 'http://localhost:3000' }

  before do
    @id = 1

    path = '%s/persons/%s.xml' % [server, @id]
    uri = URI(path)
    res = Net::HTTP.get_response(uri)

    # address = 'http://localhost:3000/persons/1.xml'
    @doc = Nokogiri::XML(res.body)
  end

  subject { @doc.xpath('//person') }

  it 'Не переданы ' do
    id = 1
    should have_tag('id').with_value(id)
  end
end
