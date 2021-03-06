require "spec_helper"

RSpec.describe ActiveRecord do
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

  describe ".where" do
    it "finds record based on off query" do
      relation = Post.where("id = 2").where("title IS NOT NULL")

      expect(relation.to_sql).to eq(
        "SELECT * FROM posts WHERE id = 2 AND title IS NOT NULL",
      )

      post = relation.first
      expect(post.id).to eq(2)
    end
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
