# frozen_string_literal: true

require "erb"

module Ebook
  class PageContext

    def initialize(content:, title:)
      fail ArgumentError, "`content` must not be an empty string" if content == ""
      fail ArgumentError,   "`title` must not be an empty string" if title == ""
      @content = content
      @title = title
    end

    def get_binding
      binding
    end

  end
end
