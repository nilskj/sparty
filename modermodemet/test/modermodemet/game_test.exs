defmodule Modermodemet.Game.Test do
  use ExUnit.Case, async: false
  alias Modermodemet, as: GameManagement

  test "create_game/0 creates a game and returns it" do
    assert {:ok, %GameManagement.Game{} = game} = GameManagement.create_game()

    # Assert the game's default fields
    assert game.turn == 0
  end

  test "list_games/0 returns a list of games" do
    # Start by ensuring no games are running
    assert {:ok, []} = GameManagement.list_games()

    # Create a game
    {:ok, _game} = GameManagement.create_game()

    # Now list_games should return at least one game
    assert {:ok, games} = GameManagement.list_games()
    assert length(games) > 0
  end
end

