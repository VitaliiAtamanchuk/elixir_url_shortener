defmodule UrlShortener.Main.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :token, :string
    field :url, :string

    timestamps()
  end

  @http_regex ~r/^(?:(?:https?|ftp):\/\/)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\x{00a1}-\x{ffff}0-9]+-?)*[a-z\x{00a1}-\x{ffff}0-9]+)(?:\.(?:[a-z\x{00a1}-\x{ffff}0-9]+-?)*[a-z\x{00a1}-\x{ffff}0-9]+)*(?:\.(?:[a-z\x{00a1}-\x{ffff}]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?$/ius

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:url])
    |> create_token
    |> validate_required([:url])
    |> validate_format(:url, @http_regex)
    |> unique_constraint(:token)
  end

  # defp create_token(%Ecto.Changeset{valid?: true} = changeset) do
  defp create_token(changeset) do
    length = 8

    change(
      changeset,
      %{
        token:
          :crypto.strong_rand_bytes(length)
          |> Base.url_encode64()
          |> binary_part(0, length)
      }
    )
  end
end
