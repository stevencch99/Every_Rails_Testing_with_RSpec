require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do

    # user = User.create!(
    #   first_name: "Joe",
    #   last_name: "Tester",
    #   email: "joetester180709@example.com",
    #   password: "dottle-nouveau-pavilion-tights-furze",
    #   )

    # Call trait of user in factories/users.rb
    user = FactoryBot.create(:user, :male_user)

    user.projects.create!(
      name: "Test Project",
      )

    new_project = user.projects.build(
      name: "Test Project",
      )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end

  it "allows two users to share a project name" do
    # user = User.create!(
    #   first_name: "Joe",
    #   last_name:  "Tester",
    #   email:      "project_test_joetester2@example.com",
    #   password:   "dottle-nouveau-pavilion-tights-furze",
    #   )
    user = FactoryBot.create(:user, :male_user)
    user.projects.create!(
      name: "Test Project",
      )

    other_user = FactoryBot.create(:user, first_name: "Jane", last_name: "Tester" )
    # other_user = User.create!(
    #   first_name: "Jane",
    #   last_name:  "Tester",
    #   email:      "note_test_janetester180709@example.com",
    #   password:   "dottle-nouveau-pavilion-tights-furze",
    #   )

    other_project = other_user.projects.build(
      name: "Test Project",
      )

    expect(other_project).to be_valid
  end

  describe "late status" do
    it "is late when the due date is past today" do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it "is on time when the due date is today" do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it "is on time when the due date is in the future" do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end

    it "can have many notes" do
      project = FactoryBot.create(:project, :with_notes)
      expect(project.notes.length).to eq 5
    end
  end
end
