# frozen_string_literal: true

require "active_record"

module Integral
  module WebScraper
    class Page < ActiveRecord::Base

      # Scopes

      scope :downloaded,     ->{ where.not(downloaded_html: "") }
      scope :not_downloaded, ->{ where(downloaded_html: "") }
      scope :for_epub,       ->{ where.not(epub_html: "") }

      # Validations

      validates :url, presence: true, format: %r{(http|https)://}, uniqueness: true

    end
  end
end
