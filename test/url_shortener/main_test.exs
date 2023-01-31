defmodule UrlShortener.MainTest do
  use UrlShortener.DataCase

  alias UrlShortener.Main

  describe "items" do
    alias UrlShortener.Main.Item

    import UrlShortener.MainFixtures

    @invalid_attrs %{id: nil, url: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Main.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Main.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{id: "some id", url: "some url"}

      assert {:ok, %Item{} = item} = Main.create_item(valid_attrs)
      assert item.id == "some id"
      assert item.url == "some url"
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Main.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{id: "some updated id", url: "some updated url"}

      assert {:ok, %Item{} = item} = Main.update_item(item, update_attrs)
      assert item.id == "some updated id"
      assert item.url == "some updated url"
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Main.update_item(item, @invalid_attrs)
      assert item == Main.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Main.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Main.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Main.change_item(item)
    end
  end
end
