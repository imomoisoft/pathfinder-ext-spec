require "rubygems"
require "bundler/setup"
Bundler.require(:default)

# require 'open-uri'
require 'net/http'

Object.class_eval do
  def __(text)
    raise text
  end
end

Spork.prefork do
  require 'rspec/autorun'

  # Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  # I18n.locale = :ru

  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run :focus
    config.mock_with :rspec

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = 'random'
  end
end

Spork.each_run do
end

