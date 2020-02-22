# frozen_string_literal: true

RSpec.describe Integral::WebScraper do
  subject { described_class::VERSION }
  it { is_expected.not_to be nil }
end
