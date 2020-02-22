# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

module Ebook
  class Opf

    PATH = "output/epub/OEBPS/content.opf".freeze

    def initialize(pages_data:)
      fail ArgumentError, "`pages_data` must be an Array" unless pages_data.is_a? Array
      @context = OpfContext.new(pages_data)
    end

    def build_xml
      fail ArgumentError, "layout file is empty" if template.to_s == ""
      bnd = @context.get_binding
      ERB.new(template, 0, '>').result(bnd)
    end

    def build_and_write!
      File.open(PATH, "w") do |file|
        file << build_xml
      end
    end

    private

    def template
      File.read "templates/opf.erb"
    end

  end
end
