require "spec_helper"

RSpec.describe ActionDispatch do
  describe "#add_route" do
    it "adds routes successfully" do
      routes = ActionDispatch::Routing::RouteSet.new
      route = routes.add_route "GET", "/posts", "posts", "index"

      expect(route.controller).to eq("posts")
      expect(route.action).to eq("index")
    end
  end

  describe "#find_route" do
    it "finds routes successfully" do
      routes = ActionDispatch::Routing::RouteSet.new
      routes.add_route "GET", "/posts", "posts", "index"
      routes.add_route "POST", "/posts", "posts", "create"

      request = Rack::Request.new(
        "REQUEST_METHOD" => "POST",
        "PATH_INFO" => "/posts",
      )
      route = routes.find_route(request)

      expect(route.controller).to eq("posts")
      expect(route.action).to eq("create")
    end
  end

  describe "#draw" do
    it "parses routes successfully" do
      routes = ActionDispatch::Routing::RouteSet.new
      routes.draw do
        get "/hello", to: "hello#index"
        root to: "posts#index"
        resources :posts
      end

      request = Rack::Request.new(
        "REQUEST_METHOD" => "GET",
        "PATH_INFO" => "/posts/new",
      )
      route = routes.find_route(request)

      expect(route.controller).to eq("posts")
      expect(route.action).to eq("new")
      expect(route.name).to eq("new_post")
    end
  end
end
