require 'rails_helper'

RSpec.describe "examples/index", type: :view do
  before(:each) do
    assign(:examples, [
      Example.create!(
        title: "Title"
      ),
      Example.create!(
        title: "Title"
      )
    ])
  end

  it "renders a list of examples" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
  end
end
