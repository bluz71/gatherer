require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before do
    sign_in User.create!(email: "rspec@example.com", password: "password")
  end

  describe "POST create" do
    it "creates a project" do
      post :create, project: { name: "Runway", tasks: "Start something:2" }
      expect(response).to redirect_to(projects_path)
      expect(assigns(:action).project.name).to eq("Runway")
    end

    it "goes back to form on failure" do
      post :create, project: { name: "", tasks: "" }
      expect(response).to render_template(:new)
      expect(assigns(:project)).to be_present
    end
  end

  describe "graceful modification failures" do
    it "fails create gracefully" do
      action_stub = double(create: false, project: Project.new)
      expect(CreatesProject).to receive(:new).and_return(action_stub)
      post :create, project: { name: "Project Runway" }
      expect(response).to render_template(:new)
    end
  end

  describe "GET show" do
    let(:project) { Project.create(name: "Project Runway") }

    it "allows a user who is part of the project to see the project" do
      allow(controller.current_user).to receive(:can_view?).and_return(true)
      get :show, id: project.id
      expect(response).to render_template(:show)
    end

    it "does not allow a user who is not part of the project to see the project" do
      allow(controller.current_user).to receive(:can_view?).and_return(false)
      get :show, id: project.id
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
