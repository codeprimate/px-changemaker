defmodule Pxapp4.ApiController do
  use Phoenix.Controller

  plug :action

  def make(conn, params) do
    value = params["value"]
    json conn, %{ value: value,
                  change: Change.from(value) }
  end

end
