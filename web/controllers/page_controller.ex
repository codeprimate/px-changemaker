defmodule Pxapp4.PageController do
  use Phoenix.Controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end

  def change(conn, params) do
    render conn, "change.html", get_change(params)
  end

  defp get_change(params) do
    value = params["value"]
    case value do
      nil -> %{value: nil, change: [] }
      _ -> %{value: value, change: Change.from(value)}
    end
  end

end
