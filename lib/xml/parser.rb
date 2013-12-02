FILENAME = "dummy"
PATH = "spec/fixtures/#{FILENAME}.xml"

require 'nokogiri'

module XML
  class Parser
    attr_accessor :path

    def initialize(path=PATH)
      @path = path
    end

    def stream
      parser = Nokogiri::XML::SAX::Parser.new(XML::Configuration.new)
      parser.parse(File.read(@path))
      parser.document.content
    end
  end

  class Configuration < Nokogiri::XML::SAX::Document

    attr_accessor :content

    def initialize
      @content = {title: "Biomart", menu: []}
    end

    def start_element name, attributes = []
      if name == "config" && attributes.size > 1
        master_attr  = attributes[11].first
        master_value = attributes[11].last
        a = Hash[attributes]
        @content[:menu] <<  { title: a["displayname"] } if master_value == "false"
      end
    end

    def end_document
      #puts "the document has ended"
      @content
    end
  end

end
