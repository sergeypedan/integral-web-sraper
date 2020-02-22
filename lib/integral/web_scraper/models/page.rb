# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

require "active_record"

module Integral
  module WebScraper
    class Page < ActiveRecord::Base

      # Scopes

      scope :downloaded,     ->{ where.not(downloaded_html: [nil, ""]) }
      scope :not_downloaded, ->{ where(downloaded_html: [nil, ""]) }
      scope :for_epub,       ->{ where.not(epub_html: [nil, ""]) }

      # Validations

      # validates :url, presence: true, format: %r{(http|https)://}, uniqueness: { message: "is duplicate: %{value}" }
      validates :url, presence: true, format: %r{(http|https)://}
      validates_uniqueness_of :url, message: "is duplicate: %{value}"

    end
  end
end
