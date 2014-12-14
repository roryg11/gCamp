require 'rails_helper'

feature 'CRUDing projects' do
  scenario 'creating a new project ' do
    visit projects_path
    click_on 'new-project-action'
    fill_in "Name", with: "Im a project"
    click_on 'submit-project-action'

    expect(page).to have_content("Im a project")
    expect(page).to have_content("Project successfully created")
  end

  scenario 'showing projects index' do
    Project.create!(
      name: "im a project"
    )

    Project.create!(
      name: "im also a project"
    )

    visit projects_path

    expect(page).to have_content("im a project")
    expect(page).to have_content("im also a project")
  end

  scenario 'showing individual project' do
    project=Project.create!(
    name: "im a project"
    )

    visit projects_path
    click_on "show-project-#{project.id}-action"

    expect(page.current_path).to eq(project_path(project))
  end

  scenario "editing a project" do
    project=Project.create!(
    name: "im a project"
    )

    visit projects_path
    click_on "show-project-#{project.id}-action"
    click_on "edit-project-#{project.id}-action"
    fill_in "Name", with: "im an edited project"
    click_on "submit-project-action"

    expect(page).to have_content("im an edited project")
    expect(page).to have_content("Project successfully updated")
  end

  scenario 'deleting a project' do
    project=Project.create!(
    name: "im a project"
    )

    visit projects_path
    click_on "show-project-#{project.id}-action"
    click_on "delete-project-#{project.id}-action"

    expect(page).to have_no_content("im a project")
    expect(page).to have_content("Project successfully deleted")
  end
end

feature "validating input" do
  scenario "user inputs blank project name" do

    visit projects_path
    click_on 'new-project-action'
    click_on 'submit-project-action'

    expect(page).to have_content("Name can't be blank")
  end
end
