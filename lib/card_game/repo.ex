defmodule CardGame.Repo do
  use Ecto.Repo,
    otp_app: :card_game,
    adapter: Ecto.Adapters.Postgres
end
