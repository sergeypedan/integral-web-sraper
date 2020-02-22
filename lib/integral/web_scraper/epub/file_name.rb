# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

module Epub
  module FileName

    OUTPUT_DIR_NAME = "output/epub/OEBPS/html".freeze

    module_function

    # def file_base_name_from_url(url)
    #   url.file_name_from_url(url).sub(".html", "")
    # end

    # def file_name_from_url(url)
    #   fail ArgumentError, "`url` must not be empty" if url.to_s.nil?
    #   fail ArgumentError, "`url` must be a String" unless url.is_a? String
    #   url.sub(Book::PAGES_BASE, "")
    # end

    # def file_name_w_index_from_url(url, index)
    #   [
    #     index.to_s.rjust(3, "0"),
    #     "-",
    #     file_name_from_url(url)
    #   ].join
    # end

    def output_file_path(index)
      fail ArgumentError, "`index` must be an Integer" unless index.is_a? Integer
      [OUTPUT_DIR_NAME, "/", output_file_name(index), ".xhtml"].join
    end

    def output_file_name(index)
      fail ArgumentError, "`index` must be an Integer" unless index.is_a? Integer
      ["page-", index.to_s.rjust(4, "0")].join
    end

  end
end
