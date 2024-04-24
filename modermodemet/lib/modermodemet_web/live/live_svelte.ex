defmodule ModermodemetWeb.SvelteExample do
  use ModermodemetWeb, :live_view
  use LiveSvelte.Components

  def render(assigns) do
    ~H"""
    <.Example number={@number} socket={@socket} />
    """
  end

  def handle_event("set_number", %{"number" => number}, socket) do
    {:noreply, assign(socket, :number, number)}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :number, 5)}
  end
end
