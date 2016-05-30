require 'spec_helper'

feature 'index page' %q{Main page of game 'Codebreaker', where can set property need for the game} do
  scenario 'username input data' do
    visit('/')
    fill_in 'user', with:'testuser'
    click_on 'START GAME'
    expect(page).to have_content('Game')
  end

  scenario 'username invalid input data' do
    visit('/')
    fill_in 'user', with:'testuser'
    click_on 'START GAME'
    expect(page).to have_content('Game')
  end
end