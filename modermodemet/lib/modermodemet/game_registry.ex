defmodule Modermodemet.GameRegistry do
  def child_spec([]) do
    %{
      id: __MODULE__,
      start: {Registry, :start_link, [[keys: :unique, name: __MODULE__]]}
    }
  end

  @doc """
  Returns the PID for given game id.
  """
  def lookup_pid(game_id) do
    case Registry.lookup(__MODULE__, game_id) do
      [] -> :error
      [{pid, _}] -> {:ok, pid}
    end
  end
end
