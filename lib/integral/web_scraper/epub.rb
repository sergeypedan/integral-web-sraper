# frozen_string_literal: true

module Epub

  INFO = YAML.load(File.read("./book.yml"))

  AUTHORS           = INFO["authors"]
  CONTRIBUTORS      = INFO["contributors"]
  ID                = INFO["id"]
  LANGUAGE          = INFO["language"]
  PAGES_BASE        = INFO["pages_base"]
  PAGE_URLS         = INFO["page_urls"]
  STRIP_FROM_TITLE  = INFO["strip_from_title"]
  TITLE             = INFO["title"]

end
