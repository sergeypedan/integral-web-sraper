# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

require "erb"

module Ebook
  class Wrapper

    def initialize(content:, title:)
      @context = PageContext.new(content: content, title: title)
    end

    def html
      fail ArgumentError, "layout file is empty" if template.to_s == ""
      ERB.new(template, 0, '>').result(@context.get_binding)
    end

    private

    def template
      File.read "templates/layout.erb"
    end

  end
end
