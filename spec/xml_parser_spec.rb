require "spec_helper"

describe "XML Parser" do
  XML_PATH = "spec/fixtures/dummy.xml"
  CONTENT = {
    title: "Biomart",
    menu: [ { title: "Gene Vega STOCA" },
            { title: "Geni Alata" },
            { title: "GENE VEGA STICA" },
            { title: "Gennaro" },
            { title: "GENE THAT BOTHERS" },
            { title: "GEnI0"} ]
 }
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
