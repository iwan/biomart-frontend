FILENAME = "GenePrioritizationPrototype"
PATH = "/Users/federicocortini/code/HSR/biomart-rc7/#{FILENAME}.xml"

module XML
  class Parser
    attr_accessor :path

    def initialize(path=PATH)
      @path = path
    end

  end
end
