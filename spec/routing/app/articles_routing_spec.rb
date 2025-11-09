require "rails_helper"

RSpec.describe App::ArticlesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/app/articles").to route_to("app/articles#index")
    end

    it "routes to #new" do
      expect(get: "/app/articles/new").to route_to("app/articles#new")
    end

    it "routes to #show" do
      expect(get: "/app/articles/1").to route_to("app/articles#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/app/articles/1/edit").to route_to("app/articles#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/app/articles").to route_to("app/articles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/app/articles/1").to route_to("app/articles#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/app/articles/1").to route_to("app/articles#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/app/articles/1").to route_to("app/articles#destroy", id: "1")
    end
  end
end
