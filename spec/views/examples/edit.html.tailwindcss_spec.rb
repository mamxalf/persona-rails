require 'rails_helper'

RSpec.describe "examples/edit", type: :view do
  before(:each) do
    @example = assign(:example, Example.create!(
      title: "MyString"
    ))
  end

  it "renders the edit example form" do
    render

    assert_select "form[action=?][method=?]", example_path(@example), "post" do

      assert_select "input[name=?]", "example[title]"
    end
  end
end
