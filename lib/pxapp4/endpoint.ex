defmodule Pxapp4.Endpoint do
  use Phoenix.Endpoint, otp_app: :pxapp4

  plug Plug.Static,
    at: "/", from: :pxapp4

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_pxapp4_key",
    signing_salt: "yx2bIWSS",
    encryption_salt: "pP57QG8I"

  plug :router, Pxapp4.Router
end
