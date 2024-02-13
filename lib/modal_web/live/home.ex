defmodule ModalWeb.Home do
  use ModalWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>Welcome to Phoenix!</h1>
    <.modal :if={@show_modal} id="modal" show on_cancel={JS.navigate(~p"/home")}>
      this is a modal
    </.modal>
    <.button phx-click="show_modal">Show Modal</.button>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, show_modal: false)}
  end

  def handle_event("show_modal", _, socket) do
    {:noreply, assign(socket, show_modal: true)}
  end
end
