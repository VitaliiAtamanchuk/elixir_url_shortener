defmodule UrlShortener.MainFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UrlShortener.Main` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        id: "some id",
        url: "some url"
      })
      |> UrlShortener.Main.create_item()

    item
  end
end
