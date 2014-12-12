require 'rails_helper'

feature "CRUDing users" do
  scenario 'creating a new User' do

    visit users_path
    click_on 'New User'
    fill_in "First name", with: 'Test'
    fill_in "Last name", with: 'Test last'
    fill_in "Email", with: 'Test@test.com'
    click_on 'Create User'

    expect(page).to have_content('Test')
    expect(page).to have_content('Test last')
    expect(page).to have_content('Test@test.com')
  end

  scenario 'showing a user' do
    User.create!(
      first_name: "test",
      last_name: "Mctest",
      email: "test@mctest.com",
    )

    visit users_path
    click_on 'test Mctest'

    expect(page).to have_content("test")
    expect(page).to have_content("Mctest")
    expect(page).to have_content("test@mctest.com")
  end

end
