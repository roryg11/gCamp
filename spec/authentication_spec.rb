require 'rails_helper'

feature 'Signing into Account ' do
  scenario 'user signs in with matching password and email' do
    User.create!(
    first_name: "Bill",
    last_name: "Nye",
    email: "thescienceguy@pbs.org",
    password: "science",
    password_confirmation: "science"
    )


    visit root_path
    click_on "signin-action"
    fill_in "Email", with: "thescienceguy@pbs.org"
    fill_in "Password", with: "science"
    click_on "submit-signin-action"

    expect(page).to have_content("Bill Nye")
  end

  scenario 'user tries to sign in with mismatched email and password' do
    User.create!(
    first_name: "Bill",
    last_name: "Nye",
    email: "thescienceguy@pbs.org",
    password: "science",
    password_confirmation: "science"
    )

    visit signin_path
    fill_in "Email", with: "thescienceguy@pbs.org"
    fill_in "Password", with: "universe"
    click_on "submit-signin-action"

    expect(page).to have_content("Username / password combination is invalid")
  end

  scenario 'user tries to sign in with blank email and password' do

    visit signin_path
    click_on "submit-signin-action"

    expect(page).to have_content("Username / password combination is invalid")
  end

  scenario 'user tries to sign in with email and password that do no exist in database' do
    visit signin_path
    fill_in "Email", with: "thescienceguy@pbs.org"
    fill_in "Password", with: "universe"
    click_on "submit-signin-action"

    expect(page).to have_content("Username / password combination is invalid")
  end
end
