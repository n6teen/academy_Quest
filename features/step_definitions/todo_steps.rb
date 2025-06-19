Given("I am on the todos page") do
  visit todos_path
end

Given("a todo exists with the title {string}") do |title|
  Todo.create!(title: title, status: false)
end

When("I reload the page") do
  visit current_path
end

When("I fill in the todo input with {string}") do |text|
  find('[data-testid="todo-input"]').fill_in(with: text)
end

When("I click the add button") do
  find('[data-testid="add-todo-button"]').click
end

When("I check the quest status checkbox") do
  find('[data-testid="todo-checkbox"]').click
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end

Then("I should not see {string}") do |text|
  expect(page).not_to have_content(text)
end

Then("I should see the quest is checked") do
  expect(find('[data-testid="todo-checkbox"]')).to be_checked
end

When("I click the delete todo button") do
  find('[data-testid="delete-todo-button"]', match: :first).click
end

When("I click the brag button") do
  find("[data-testid='brag-button']").click
end

Then("I should be on the brags page") do
  expect(page).to have_current_path(brags_path, ignore_query: true)
end

When("I click the back button") do
  find("[data-testid='back-button']").click
end

Then("I should be on the quest page") do
  expect(page).to have_current_path(todos_path, ignore_query: true)
end
