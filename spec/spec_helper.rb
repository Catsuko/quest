require_relative '../quest.rb'

RSpec.shared_context 'grid setup' do
  let(:grid_scale) { 8 }
  before(:each) { GridPosition.scale = grid_scale }
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.warnings = true
  config.include_context 'grid setup'
end
