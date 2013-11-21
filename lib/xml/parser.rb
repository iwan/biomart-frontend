FILENAME = "GenePrioritizationPrototype"
PATH = "/Users/federicocortini/code/HSR/biomart-rc7/#{FILENAME}.xml"

require 'nokogiri'

module XML
  class Parser
    attr_accessor :path

    def initialize(path=PATH)
      @path = path
      @doc = Nokogiri::XML(File.open(@path))
    end

    def get_element(element)
      @menu = []
      @doc.xpath(element).each do |e|
        @menu << e.attr('displayname')
      end
      @menu
    end

  end
end
