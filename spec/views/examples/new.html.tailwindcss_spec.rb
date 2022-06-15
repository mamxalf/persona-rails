require 'rails_helper'

RSpec.describe 'examples/new', type: :view do
  before(:each) do
    assign(:example, Example.new(
                       title: 'MyString'
    ))
  end

  it 'renders new example form' do
    render

    assert_select 'form[action=?][method=?]', examples_path, 'post' do
      assert_select 'input[name=?]', 'example[title]'
    end
  end
end
