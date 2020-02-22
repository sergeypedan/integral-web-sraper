# encoding: UTF-8
# frozen_string_literal: true
# warn_indent: true

module Integral
  module Epub
    class Saver

      def self.save_epub_page!(html, index)
        name = Name.output_file_path(index)
        File.open(name, "w") do |f| f << html end
      end

      def self.create_epub!
        puts "Creating ePub"
        Dir.chdir("output/epub")
        system "zip -0Xq my-book.epub mimetype"  # create the new ZIP archive and add the mimetype file with no compression
        system "zip -Xr9Dq my-book.epub *"        # add the remaining items
        # The flags -X and -D minimize extraneous information in the .zip file
        # -r will recursively include the contents of META-INF and OEBPS directories
        # https://www.ibm.com/developerworks/xml/tutorials/x-epubtut/index.html
      end

    end
  end
end
