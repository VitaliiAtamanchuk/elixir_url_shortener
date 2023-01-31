defmodule UrlShortenerWeb.MainController do
  use UrlShortenerWeb, :controller

  alias UrlShortener.Main
  alias UrlShortener.Main.Item

  def index(conn, %{"token" => token}) do
    item = Main.get_by_item!(token)
    redirect(conn, external: item.url)
  end

  def create(conn, %{"item" => item_params}) do
    with {:ok, %Item{} = item} <- Main.create_item(item_params) do
      conn
      |> put_status(:created)
      |> render("created.json", item: item)
    end
  end
end
