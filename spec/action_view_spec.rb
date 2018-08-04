require "spec_helper"

RSpec.describe ActionView do
  describe "rendering a template" do
    it "renders successfully" do
      def render_template
        template = ActionView::Template.new(
          "<p>Hello, world</p>",
          "render_template",
        )

        context = ActionView::Base.new

        expect(template.render(context)).to eq("<p>Hello, world</p>")
      end
    end

    it "renders with variables" do
      def render_template_with_variables
        template = ActionView::Template.new(
          "<p><%= @var %></p>",
          "render_template_with_variables",
        )

        context = ActionView::Base.new(var: "Hello")

        expect(template.render(context)).to eq("<p>Hello</p>")
      end
    end

    it "renders with yield" do
      def render_with_yield
        template = ActionView::Template.new(
          "<p><%= yield %></p>",
          "render_with_yield",
        )

        context = ActionView::Base.new

        expect(template.render(context) { "Hello" }).to eq("<p>Hello</p>")
      end
    end

    it "renders with helper" do
      def render_with_helper
        template = ActionView::Template.new(
          "<%= link_to 'title', '/url' %>",
          "render_with_helper",
        )

        context = ActionView::Base.new

        expect(template.render(context)).to eq("<a href=\"/url\">title</a>")
      end
    end

    it "finds template" do
      file = "#{__dir__}/muffin_blog/app/views/posts/index.html.erb"
      template_one = ActionView::Template.find(file)
      template_two = ActionView::Template.find(file)

      expect(template_one).to eq(template_two)
    end
  end
end