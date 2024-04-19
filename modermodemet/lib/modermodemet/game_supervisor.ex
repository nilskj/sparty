defmodule Modermodemet.GameSupervisor do
  use DynamicSupervisor

  def init([]) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_game(%Modermodemet.Game{} = game) do
    DynamicSupervisor.start_child(__MODULE__, %{
      id: game.id,
      start: {Modermodemet.GameServer, :start_link, [game]},
      restart: :transient
    })
  end

  def start_link([]) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end
end
