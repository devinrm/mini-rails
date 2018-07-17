require "spec_helper"

require "active_record"
require "muffin_blog/app/models/application_record"
require "muffin_blog/app/models/post"

RSpec.describe ActiveRecord do
  before do
    Post.establish_connection(
      database: "#{__dir__}/muffin_blog/db/development.sqlite3",
    )
  end

  describe "#initialize" do
    it "initializes successfully" do
      post = Post.new(id: 1, title: "My first post")

      expect(post.id).to eq(1)
      expect(post.title).to eq("My first post")
    end
  end

  describe ".find" do
    it "finds individual record successfully" do
      post = Post.find(1)

      expect(post).to be_a(Post)
      expect(post.id).to eq(1)
      expect(post.title).to eq("Blueberry Muffins")
    end
  end

  describe ".all" do
    it "finds first record successfully" do
      post = Post.all.first

      expect(post).to be_a(Post)
      expect(post.id).to eq(1)
      expect(post.title).to eq("Blueberry Muffins")
    end
  end

  it ".where" do
    relation = Post.where("id = 2").where("title IS NOT NULL")

    expect(relation.to_sql).to eq(
      "SELECT * FROM posts WHERE id = 2 AND title IS NOT NULL",
    )

    post = relation.first
    expect(post.id).to eq(2)
  end

  it "executes sql" do
    rows = Post.connection.execute("SELECT * FROM posts")

    expect(rows).to be_an(Array)

    row = rows.first

    expect(row).to be_a(Hash)
    expect(row.keys).to eq(
      %i[id title body created_at updated_at],
    )
  end
end
