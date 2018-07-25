require "spec_helper"

RSpec.describe ActionController do
  describe "controller actions" do
    class TestController < ActionController::Base
      before_action :callback, only: [:show]

      def index
        response << "index"
      end

      def show
        response << "show"
      end

      private

      def callback
        response << "callback"
      end
    end

    describe "#index" do
      it "calls index successfully" do
        controller = TestController.new
        controller.response = []
        controller.process(:index)

        expect(controller.response).to eq(["index"])
      end
    end

    describe "#callback" do
      it "is successful" do
        controller = TestController.new
        controller.response = []
        controller.process(:show)

        expect(controller.response).to eq(["callback", "show"])
      end
    end
  end

  describe "a real controller" do
    class Request
      def params
        { "id" => 1 }
      end
    end

    it "works correctly" do
      controller = PostsController.new
      controller.request = Request.new
      controller.process(:show)
    end
  end
end
