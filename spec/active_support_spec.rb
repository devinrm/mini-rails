require "spec_helper"

RSpec.describe ActiveSupport do
  describe ".search_for_file" do
    it "finds the file successfully" do
      file = ActiveSupport::Dependencies.search_for_file("application_controller")

      expect(file).to eq("#{__dir__}/muffin_blog/app/controllers/application_controller.rb")
    end

    it "returns nil if file does not exist" do
      file = ActiveSupport::Dependencies.search_for_file("unknown")

      expect(file).to be_nil
    end
  end

  describe ".underscore" do
    it "return a snake-cased string" do
      expect(:Post.to_s.underscore).to eq("post")
      expect(:ApplicationController.to_s.underscore).
        to eq("application_controller")
    end
  end

  it "loads missing constants" do
    Post
  end
end
