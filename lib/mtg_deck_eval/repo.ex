defmodule MtgDeckEval.Repo do
  use Ecto.Repo,
    otp_app: :mtg_deck_eval,
    adapter: Ecto.Adapters.Postgres
end
