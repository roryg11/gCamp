require 'rails_helper'

feature 'Signing Up' do
  scenario 'user enters first name, last name, email, password and confirmation' do

    visit root_path
    click_on "signup-action"
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "Nye"
    fill_in "Email", with: "thescienceguy@pbs.org"
    fill_in "Password", with: "science"
    fill_in "Password confirmation", with: "science"
    click_on "submit-signup-action"

    expect(page).to have_content("Bill Nye")
    #should we be expecting some sort of session id?
  end

  scenario 'User submits blank form' do
    visit signup_path
    click_on "submit-signup-action"

    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end

  scenario 'User submits password and password confirmation that do not match' do

    visit signup_path
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "Nye"
    fill_in "Email", with: "thescienceguy@pbs.org"
    fill_in "Password", with: "science"
    fill_in "Password confirmation", with: "poop"
    click_on "submit-signup-action"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  scenario 'User submits an email that already exists in the database' do
    User.create!(
      first_name: "Neil",
      last_name: "Degrasse-Tyson",
      email: "thescienceguy@pbs.org",
      password: "universe",
      password_confirmation: "universe"
    )

    visit signup_path
    fill_in "First name", with: "Bill"
    fill_in "Last name", with: "Nye"
    fill_in "Email", with: "thescienceguy@pbs.org"
    fill_in "Password", with: "science"
    fill_in "Password confirmation", with: "science"
    click_on "submit-signup-action"

    expect(page).to have_content("Email has already been taken")
  end
end
