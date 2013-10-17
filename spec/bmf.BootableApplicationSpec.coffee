describe "mb.BootableApplication", ->
  it "should say hello when booted", ->
    element = $("<div>")
    app = new bmf.BootableApplication(element)
    expect(element.text()).toMatch "Biomart Frontend"

