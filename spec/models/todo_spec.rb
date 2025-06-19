require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      todo = Todo.new(title: "do homework", status: false)
      expect(todo).to be_valid
    end

    it "is not valid without a title" do
      todo = Todo.new(title: nil, status: false)
      expect(todo).not_to be_valid
    end

    it "is not valid with a nil status" do
      todo = Todo.new(title: "do homework", status: nil)
      expect(todo).not_to be_valid
    end

    it "is not valid with an empty title" do
      todo = Todo.new(title: "", status: false)
      expect(todo).not_to be_valid
    end
  end
end
