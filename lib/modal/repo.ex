defmodule Modal.Repo do
  use Ecto.Repo,
    otp_app: :modal,
    adapter: Ecto.Adapters.Postgres
end
