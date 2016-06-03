feature 'Codebreaker rack' do
  let(:home_page){ visit('/') }
  let(:game_page){ visit('/game') }
  let(:username_input) do
    fill_in 'user', with:'bla-bla'
    click_on 'Start Game' 
  end
  let(:start_game) do
    home_page
    username_input
  end 

  describe "home_page '/'" do
    scenario 'welcome msgs' do
      home_page
      expect(page).to have_content('Welcome to Codebreaker!')
      expect(page).to have_content('About game')
      expect(page).to have_content('Scores')
    end


    context "input username data" do
      scenario 'invalid' do
        home_page
        fill_in 'user', with:''
        click_on 'Start Game'
        expect(page).to have_content('')
      end

      scenario 'valid' do
        home_page
        username_input
        expect(page).to have_content('Current Scores')
      end
    end
  end

  describe "game_page '/game'" do
    context "access to game_page " do
      scenario "when not found user data then redirect to home_page" do
        home_page
        game_page
        expect(page).not_to have_content('Current Scores')
      end

      scenario "when found, then start game" do
        start_game
        expect(page).to have_content('Current Scores')
      end
    end

    context "when enter secret code " do
      context "invalid" do

        scenario "more 4 nums" do
          start_game
          fill_in 'attempt', with:'24235'
          click_on 'check'
          expect(page).not_to have_content('24235')          
        end

        scenario "text insted nums" do
          start_game
          fill_in 'attempt', with:'hack'
          click_on 'check'
          expect(page).not_to have_content('hack') 
        end

      end
      context "valid" do
        scenario "input 1234 output 1234" do
          start_game
          fill_in 'attempt', with:'1234'
          click_on 'check'
          expect(page).to have_content('1234')
        end
        scenario "input 6324 output 6324" do
          start_game
          fill_in 'attempt', with:'6324'
          click_on 'check'
          expect(page).to have_content('6324')
        end
      end

      scenario "lose game(10 attempts and lose game)" do
        start_game
        10.times do
          fill_in 'attempt', with:'6666'
          click_on 'check'
        end
        expect(page).to have_content('LOSER!!!')
      end
    end
  end
end