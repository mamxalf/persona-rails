require 'rails_helper'

RSpec.describe 'examples/show', type: :view do
  before(:each) do
    @example = assign(:example, Example.create!(
                                  title: 'Title'
    ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Title/)
  end
end
