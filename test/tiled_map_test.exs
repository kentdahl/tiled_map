defmodule TiledMapTest do
  use ExUnit.Case
  doctest TiledMap

  test "load minimal map" do
    {:ok, map} = TiledMap.parse_json(minimal_map_json_example_str)
    assert map.height == 4
    assert map.width  == 4
    assert map.tilewidth == 32
  end

  defp minimal_map_json_example_str do
    ~s(
      {
        "backgroundcolor":"#656667",
        "height":4,
        "layers":[ ],
        "nextobjectid":1,
        "orientation":"orthogonal",
        "properties":
        {
          "mapProperty1":"one",
          "mapProperty2":"two"
        },
        "renderorder":"right-down",
        "tileheight":32,
        "tilesets":[ ],
        "tilewidth":32,
        "version":1,
        "width":4
      }
    )
  end

  test "load file map" do
    {:ok, map} = TiledMap.load_json_map("test/data/map1.json")
    assert map.height == 4
    assert map.width  == 4
    assert map.tilewidth == 32
    assert Enum.count(map.layers) == 2
    [grid|rest] = map.layers
    [entities]  = rest
    assert TiledMap.Layer.tiles?(grid)
    assert TiledMap.Layer.objects?(entities)
    assert !TiledMap.Layer.tiles?(entities)
    assert !TiledMap.Layer.objects?(grid)

    assert Enum.count(map.tilesets) == 1
    tileset = List.first(map.tilesets)
    assert tileset.firstgid == 1
    assert tileset.imageheight == 192

  end
end
