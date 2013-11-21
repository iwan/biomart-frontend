require "spec_helper"

describe "XML Parser" do
  XML_PATH = "spec/fixtures/dummy.xml"
  let(:parser) { XML::Parser.new(XML_PATH) }

  it "has a default path" do
    expect(parser.path).to eq(XML_PATH)
  end

  it "builds the menu" do
    menu = parser.get_element("//mart//config[@master='false']")
    expect(menu).to eq(["Gene Vega STOCA",
                       "Geni Alata",
                       "GENE VEGA STICA",
                       "Gennaro",
                       "GENE THAT BOTHERS",
                       "GEnI0"])
  end
end
