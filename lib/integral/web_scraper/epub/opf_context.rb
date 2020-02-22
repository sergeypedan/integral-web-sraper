# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

module Ebook
  class OpfContext

    def initialize(pages_data)
      @authors      = Book::AUTHORS
      @contributors = Book::CONTRIBUTORS
      @pages        = pages_data
      @meta         = { book_id: Book::ID, book_title: Book::TITLE, language: Book::LANGUAGE }
    end

    def get_binding
      binding
    end

  end
end
