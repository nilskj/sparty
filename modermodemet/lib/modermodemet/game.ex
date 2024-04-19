defmodule Modermodemet.Game do
  defstruct [:id, :created_at, :turn]

  def new() do
    {:ok,
     %__MODULE__{
       id: generate_game_id(),
       created_at: DateTime.utc_now(),
       turn: 0
     }}
  end

  def advance_turn(%__MODULE__{turn: turn} = game) do
    # This is where the game logic could go
    {:ok, %{game | turn: turn + 1}}
  end

  defp generate_game_id() do
    :crypto.strong_rand_bytes(5)
    |> Base.encode32()
  end
end
