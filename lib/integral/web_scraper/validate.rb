# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

require "uri"

module Integral
  module WebScraper
    class Validate

      def self.absolute!(urls)
        invalid_urls = urls.select { |url| !absolute_url?(url) }
        return true if invalid_urls.empty?
        abort ["some URLs are not valid absolute URLs:\n", invalid_urls.map { |url| "• #{url}" }.join("\n")].join
      end


      def self.absolute_url?(url)
        begin
          uri = URI.parse(url)
        rescue
          return false
        end
        return false if uri.relative?
        return false unless [URI::HTTP, URI::HTTPS].include? uri.class
        return true
      end

      def self.unique!(urls)
        duplicates = duplicates_in(urls)
        return true if duplicates.empty?
        abort ["some URLs are not unique:\n", duplicates.map { |url| "• #{url}" }.join("\n")].join
      end

      def self.duplicates_in(array)
        array.group_by(&:itself)
             .transform_values(&:size)
             .select { |key, size| size > 1 }
             .map { |key, size| key }
      end

    end

  end
end
