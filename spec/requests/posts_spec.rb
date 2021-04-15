require "rails_helper"

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      user = User.create!(
        name: "Tiger",
        email: "tiger@bigcats.org",
        password: "password",
      )

      Post.create!(
        user_id: user.id,
        title: "How to catch an antelope",
        body: "Run very fast, big claws",
      )
      Post.create!(
        user_id: user.id,
        title: "How to catch an elephant",
        body: "Can;t, too big",
      )
      Post.create!(
        user_id: user.id,
        title: "How to be orange striped",
        body: "be born a tiger",
      )
      get "/api/posts"
      posts = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(posts.length).to eq(3)
    end
  end

  describe "POST /posts" do
    it "creates a post" do
      user = User.create!(
        name: "Bret",
        email: "bret@email.com",
        password: "password",
      )
      jwt = JWT.encode(
        { user: user.id },
        "random", # the secret key
        "HS256" # the encryption algorithm
      )

      post "/api/posts",
           params: {
             user_id: user.id,
             title: "Doin Things",
             body: "A How TO Guide for How to Guys",
           },
           headers: { "Authorization" => "Bearer #{jwt}" }

      post = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(post["title"]).to eq("Doin Things")
    end
  end
end
