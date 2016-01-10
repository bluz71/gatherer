require 'rails_helper'

RSpec.describe Task do
  describe "order" do
    let!(:project) { Project.create!(name: "Project") }
    let!(:first) { project.tasks.create!(project_order: 1) }
    let!(:second) { project.tasks.create!(project_order: 2) }
    let!(:third) { project.tasks.create!(project_order: 3) }

    it "finds that a task is first or last" do
      expect(first).to be_first_in_project
      expect(first).not_to be_last_in_project
      expect(second).not_to be_first_in_project
      expect(second).not_to be_first_in_project
      expect(third).not_to be_first_in_project
      expect(third).to be_last_in_project
    end

    it "can move up" do
      expect(second.previous_task).to eq(first)
      second.move_up
      expect(first.reload.project_order).to eq(2)
      expect(second.reload.project_order).to eq(1)
    end

    it "can move down" do
      expect(second.next_task).to eq(third)
      second.move_down
      expect(third.reload.project_order).to eq(2)
      expect(second.reload.project_order).to eq(3)
    end
  end
end
