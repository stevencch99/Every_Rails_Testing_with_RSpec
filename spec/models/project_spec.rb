require 'rails_helper'

RSpec.describe Project, type: :model do
  it "does not allow duplicate project names per user" do
    user = User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "joetester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      )

    user.projects.create(
      name: "Test Project",
      )

    new_project = user.projects.build(
      name: "Test Project"
      )

    new_project.valid?
    expect(new_project.errors[:name]).to include("has already been taken")
  end
end
