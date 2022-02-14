# require "application_system_test_case"

# class GamesTest < ApplicationSystemTestCase
#   # test "visiting the index" do
#   #   visit games_url
#   #
#   #   assert_selector "h1", text: "Games"
#   # end
# end

require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end
end
