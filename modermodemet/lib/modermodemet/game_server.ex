defmodule Modermodemet.GameServer do
  use GenServer
  require Logger

  defmodule GameInfo do
    defstruct [:id, :created_at, :turn]

    def from_game(game) do
      %GameInfo{
        id: game.id,
        created_at: game.created_at,
        turn: game.turn
      }
    end
  end

  def start_link(game) do
    GenServer.start_link(__MODULE__, game, name: via_tuple(game.id))
  end

  def init(%Modermodemet.Game{} = game) do
    Logger.debug("Starting game #{game.id}")
    {:ok, game}
  end

  def game_id(game_id) when is_binary(game_id), do: game_id

  def game_id(%Modermodemet.Game{id: id}), do: id

  def get_info(game_id) do
    GenServer.call(via_tuple(game_id), :get_info)
  end

  def handle_call(:get_info, _from, game) do
    {:reply, GameInfo.from_game(game), game}
  end

  defp via_tuple(pid) when is_pid(pid), do: pid

  defp via_tuple(game_id) do
    {:via, Registry, {Modermodemet.GameRegistry, game_id}}
  end
end
