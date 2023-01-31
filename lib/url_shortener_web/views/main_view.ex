defmodule UrlShortenerWeb.MainView do
  use UrlShortenerWeb, :view
  alias UrlShortenerWeb.MainView

  def render("created.json", %{item: item}) do
    %{
      token: item.token,
      url: item.url
    }
  end
end
