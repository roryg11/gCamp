require 'rails_helper'

feature 'CRUDing tasks' do
  scenario 'user creates a task' do

    visit tasks_path
    click_on 'New Task'
    fill_in "Description", with:"take out trash"
    click_on 'Create Task'

    expect(page).to have_content("take out trash")
    expect(page).to have_content("Task was successfully created.")
  end

  scenario 'user sees a task show page on the browser' do
    Task.create!(
    description: "take out trash"
    )

    visit tasks_path
    click_on 'Show'

    expect(page).to have_content("take out trash")
  end

  scenario 'user edits a task' do
    Task.create!(
      description: "take out trash",
    )

    visit tasks_path
    click_on 'Edit'
    fill_in "Description", with: "remove trash"
    click_on 'Update Task'

    expect(page).to have_content("remove trash")
    expect(page).to have_content('Task was successfully updated.')
  end

  scenario 'user deletes task' do
    Task.create!(
    description: "take out trash"
    )

    visit tasks_path
    click_on "Delete"

    expect(page).to have_no_content("take out trash")
    expect(page).to have_content("Task was successfully destroyed.")
    expect(page.current_path).to eq(tasks_path)
  end

end
