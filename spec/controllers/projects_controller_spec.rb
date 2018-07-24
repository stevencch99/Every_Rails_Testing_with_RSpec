require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe "#index" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "responds successfully" do
        # use Devise gem to help sign_in
        sign_in @user
        get :index
        expect(response).to be_success
      end

      it "returns a 200 response" do
        sign_in @user
        get :index
        expect(response).to have_http_status "200"
      end
    end

    context "as a guest" do
      # 針對訪客的測試
      it "returns a 302 response" do
        get :index
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-in page" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#show" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: @user)
      end

      it "responses successfully" do
        sign_in @user
        get :show, params: { id: @project.id }
        expect(response).to be_success
      end
    end

    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user)
        other_user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: other_user)
      end

      it "redirect to the dashboard" do
        sign_in @user
        get :show, params: { id: @project.id }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#create" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "adds a project" do
        project_params = FactoryBot.attributes_for(:project)
        sign_in @user
        expect {
          post :create, params: { project: project_params }
        }.to change(@user.projects, :count).by(1)
      end
    end

    context "as a guest" do
      it "returns a 302 response" do
        project_params = FactoryBot.attributes_for(:project)
        post :create, params: { project: project_params }
        expect(response).to have_http_status "302"
      end

      it "redirect to the sign-page" do
        project_params = FactoryBot.attributes_for(:project)
        post :create, params: { project: project_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @project = FactoryBot.create(:project, owner: @user)
      end

      it "updates a project" do
        project_params = FactoryBot.attributes_for(:project, name: "New Project Name")
        sign_in @user
        patch :update, params: { id: @project.id, project: project_params }
        expect(@project.reload.name).to eq "New Project Name"
      end

      context "as an unauthorized user" do
        before do
          @user = FactoryBot.create(:user)
          other_user = FactoryBot.create(:user)
          @project = FactoryBot.create(:project,
            owner: other_user,
            name: "Same Old Name")
        end

        it "does not update the project" do
          project_params = FactoryBot.attributes_for(:project, name: "New name")
          sign_in @user
          patch :update, params: { id: @project.id, project: project_params }
          expect(@project.reload.name).to eq "Same Old Name"
        end

        it "redirect to  the dashboard" do
          project_params = FactoryBot.attributes_for(:project)
          sign_in @user
          patch :update, params: { id: @project.id, project: project_params }
          expect(response).to redirect_to root_path
        end
      end
    end
  end
end