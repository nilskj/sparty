defmodule Modermodemet do
  @moduledoc """
  Modermodemet keeps the contexts that define your domain
  and business logic.
  """

  def create_game() do
    {:ok, game} = Modermodemet.Game.new()

    {:ok, _game_pid} = Modermodemet.GameSupervisor.start_game(game)

    {:ok, game}
  end

  def list_games() do
    games =
      Modermodemet.GameSupervisor
      |> Supervisor.which_children()
      |> Enum.map(fn {_, pid, :worker, [Modermodemet.GameServer]} ->
        GenServer.call(pid, :get_info)
      end)

    {:ok, games}
  end
end
