require "spec_helper"

require "active_support"

RSpec.describe ActiveSupport do
  before do
    ActiveSupport::Dependencies.autoload_paths = Dir["#{__dir__}/muffin_blog/app/*"]
  end

  describe ".search_for_file" do
    it "finds the file successfully" do
      file = ActiveSupport::Dependencies.search_for_file("application_controller")
      expect(file).to eq("#{__dir__}/muffin_blog/app/controllers/application_controller.rb")
    end
  end
end
