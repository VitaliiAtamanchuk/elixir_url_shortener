defmodule UrlShortener.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :token, :string
      add :url, :string

      timestamps()
    end
  end
end
