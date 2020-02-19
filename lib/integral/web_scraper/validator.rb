# frozen_string_literal: true

require "uri"

class Validator

  def self.absolute_urls!(urls)
    invalid_urls = urls.select { |url| !self.absolute_url?(url) }
    return true if invalid_urls.empty?
    fail ArgumentError, "Some URLs are not valid absolute URLs:\n", invalid_urls.map { |url| "• #{url}" }.join("\n")
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

end
