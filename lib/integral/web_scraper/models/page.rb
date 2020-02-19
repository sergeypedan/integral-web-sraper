# frozen_string_literal: true

require "active_record"

module Integral
  module WebScraper
    class Page < ActiveRecord::Base

      scope :downloaded, -> { where.not(downloaded_html: nil) }

      validates :url, presence: true, format: %r{(http|https)://}

    end
  end
end
