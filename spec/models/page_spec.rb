# frozen_string_literal: true

RSpec.describe Integral::WebScraper::Page do

  subject { described_class.downloaded }

  context "no pages" do
    it { is_expected.to be_empty }
  end

  context "3 pages" do
    context "but no downloaded" do
    end

    context "2 downloaded" do
    end
  end

end
