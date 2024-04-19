defmodule Modermodemet.Repo do
  use Ecto.Repo,
    otp_app: :modermodemet,
    adapter: Ecto.Adapters.Postgres
end
