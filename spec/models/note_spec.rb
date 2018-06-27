require 'rails_helper'
RSpec.describe Note, type: :model do
  before do
  end
  let(:user) { User.create!(
                 first_name: "Joe",
                 last_name: "Tester",
                 email: "joetester2@example.com",
                 password: "dottle-nouveau-pavilion-tights-furze",
               )
               }
  # 將測試搜尋功能的程式碼整理在一起
  describe "search message for a term" do
    context "when a match is found" do
    end

    context "when not match is found" do
    end
    it "returns notes that match search term" do

      project = user.projects.create(
        name: "Test Project",
      )

      note1 = project.notes.create(
        message: "This is the first note.",
        user: user,
      )
      note2 = project.notes.create(
        message: "This is the second note.",
        user: user,
      )

      note3 = project.notes.create(
        message: "First, preheat the oven.",
        user: user,
      )

      expect(Note.search("first")).to include(note1, note3)
      expect(Note.search("first")).to_not include(note2)
    end

    it "returns an empty collection when no results are found" do
      user = User.create!(
        first_name: "Joe1",
        last_name:  "Tester",
        email:      "joetester1@example.com",
        password:   "dottle-nouveau-pavilion-tights-furze",
      )

      project = user.projects.create(
        name:  "Test Project",
      )

      note1 = project.notes.create(
        message: "This is the first note.",
      )
      note2 = project.notes.create(
        message: "This is the second note.",
        user: user,
      )
      note3 = project.notes.create(
        message: "First, preheat the oven.",
        user: user,
      )
      expect(Note.search("message")).to be_empty
    end
  end
end
