require "spec_helper"

describe "XML Parser" do
  XML_PATH = "fixtures/dummy.xml"
  let(:parser) { XML::Parser.new(XML_PATH) }

  it "has a default path" do
    expect(parser.path).to eq(XML_PATH)
  end
end
