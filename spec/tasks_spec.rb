require 'rails_helper'

feature 'CRUDing tasks' do
  scenario 'user can see a listing of tasks on index page' do
    Task.create!(
      description: "take out trash",
      due_date: "2014-12-17"
    )
    Task.create!(
      description: "fold laundry",
      due_date: "2014-12-20"
    )

    visit tasks_path

    expect(page).to have_content("take out trash")
    expect(page).to have_content("2014-12-17")
    expect(page).to have_content("fold laundry")
    expect(page).to have_content("2014-12-17")
  end


  scenario 'user creates a task' do

    visit tasks_path
    click_on "new-task-action"
    fill_in "Description", with:"take out trash"
    fill_in "Due date", with: "2014-12-17"
    click_on 'Create Task'

    expect(page).to have_content("take out trash")
    expect(page).to have_content("2014-12-17")
    expect(page).to have_content("Task was successfully created.")
  end

  scenario 'user creates a task with a blank description' do

    visit tasks_path
    click_on "new-task-action"
    fill_in "Due date", with: "2014-12-17"
    click_on 'Create Task'

    expect(page).to have_content("Description can't be blank")

  end

  scenario 'user creates a task with a blank date and blank description' do

    visit tasks_path
    click_on "new-task-action"
    click_on "Create Task"

    expect(page).to have_content("Description can't be blank")
  end

  scenario 'user creates a task with only description' do

    visit tasks_path
    click_on "new-task-action"
    fill_in "Description", with:"iron shirt"
    click_on "Create Task"

    expect(page).to have_content("iron shirt")
  end


  scenario 'user sees a task page when they click on \'show\'' do
    task = Task.create!(
    description: "take out trash"
    )
    Task.create!(
    description: "fold laundry"
    )

    visit tasks_path
    click_on "show-task-#{task.id}-action"

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

feature 'sorting buttons on the index page' do
  before do
    Task.create!(
      description: "clean bathroom",
      due_date: "#{Date.friday}",
      completed: false
    )

    Task.create!(
      description: "arrange flowers",
      due_date: "#{Date.monday}",
      completed: true
    )

    Task.create!(
    description: "record album",
    due_date: "#{Date.wednesday}",
    completed: false
    )
    visit tasks_path

    scenario 'clicking on description to sort alphabetically' do
       click_on 'sort-by-description-action'

       expect(page.current_path).to eq(tasks_path[order_by_desc: [params[order_by_desc]]])
       expect(page).to have_content(@tasks.order(:description))
    end

    scenario 'clicking on Due Date sorts by date' do
      click_on 'sort-by-due-date-action'

      expect(page.current_path).to eq(tasks_path[order_by_due_date: [params[order_by_due_date]]])
      expect(page).to have_content(@tasks.order(:due_date))
    end

    scenario 'clicking on completed sorts by completion' do
      click_on 'sort-by-completion-action'

      expect(page.current_path).to eq(tasks_path[order_by_due_date: [params[order_by_due_date]]])
      expect(page).to have_content(@tasks.order(:complete))
    end

    scenario 'clicking on All shows all tasks' do
      click_on 'show-incomplete-tasks-action'
      click_on 'show-all-tasks-path'

      expect(page).to have_content(Task.all)
    end

    scenario 'clicking on All shows all tasks' do
      click_on 'show-incomplete-tasks-action'

      expect(page).to have_content(Task.where(complete: false))
    end
  end
end
