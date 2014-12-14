require 'rails_helper'

feature "CRUDing users" do
  scenario 'creating a new User' do

    visit users_path
    click_on 'new-user-action'
    fill_in "First name", with: 'Test'
    fill_in "Last name", with: 'Test last'
    fill_in "Email", with: 'Test@test.com'
    click_on 'submit-action'

    expect(page).to have_content('Test')
    expect(page).to have_content('Test last')
    expect(page).to have_content('Test@test.com')
    expect(page).to have_content('User successfully created.')
  end

  scenario 'showing a user' do
    user = User.create!(
      first_name: "test",
      last_name: "Mctest",
      email: "test@mctest.com",
    )

    visit users_path
    click_on 'show-user-action'

    expect(page).to have_content("test")
    expect(page).to have_content("Mctest")
    expect(page).to have_content("test@mctest.com")
    expect(page.current_path).to eq(user_path(user.id))
  end

  scenario 'editing a user' do
    user = User.create!(
      first_name: "test",
      last_name: "Mctest",
      email: "test@mctest.com",
    )

    User.create!(
      first_name: "scrooge",
      last_name: "mcscrooge",
      email: "scrooge@scrooge.com",
    )

    visit users_path
    click_on "edit-user-#{user.id}-action"
    fill_in "First name", with: "Sam"
    fill_in "Last name", with: "Smith"
    fill_in "Email", with:"Sam.Smith@Smith.com"
    click_on 'submit-action'

    expect(page).to have_content("Sam")
    expect(page).to have_content("Smith")
    expect(page).to have_content("Sam.Smith@Smith.com")
    expect(page).to have_content("User has been successfully updated.")
  end

  scenario 'deleting a user' do
    user = User.create!(
      first_name: "test",
      last_name: "mctest",
      email: "test@mctest.com",
    )

    visit users_path
    click_on "edit-user-#{user.id}-action"
    click_on "delete-user-#{user.id}-action"

    expect(page).to have_content("User has been successfully deleted.")
  end

  scenario 'showing an index of users' do
    User.create!(
      first_name: "test",
      last_name: "mctest",
      email: "test@mctest.com"
    )

    User.create!(
    first_name: "scrooge",
    last_name: "mcscrooge",
    email: "scrooge@mcscrooge.com"
    )

    visit users_path

    expect(page).to have_content("test mctest")
    expect(page).to have_content("scrooge mcscrooge")
    expect(page).to have_content("test@mctest.com")
    expect(page).to have_content("scrooge@mcscrooge.com")
  end
end

feature 'validating input' do
  scenario 'submits blank fields for first name, last name and email' do

    visit users_path
    click_on 'new-user-action'
    click_on 'submit-action'

    expect(page).to have_content("First name can\'t be blank")
    expect(page).to have_content("Last name can\'t be blank")
    expect(page).to have_content("Email can\'t be blank")
  end
end
