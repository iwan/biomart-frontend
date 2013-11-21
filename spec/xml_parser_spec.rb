require "spec_helper"

describe "XML Parser" do
  XML_PATH = "spec/fixtures/dummy.xml"
  CONTENT  = [ "Gene Vega STOCA", "Geni Alata", "GENE VEGA STICA", "Gennaro", "GENE THAT BOTHERS", "GEnI0"]
  let(:parser) { XML::Parser.new(XML_PATH) }

  it "has a default path" do
    expect(parser.path).to eq(XML_PATH)
  end

  it "builds the menu" do
    parser = XML::Parser.new
    content = parser.stream
    expect(content).to eq(CONTENT)
  end
end
