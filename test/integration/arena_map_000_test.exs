defmodule TiledMapTest.ArenaMap000Test do
  use ExUnit.Case

  setup do
    {:ok, map} = TiledMap.load_json_map("test/data/arena000.json")
    {:ok, [map: map]}
  end

  test "map info", context do
    map = context[:map]

    assert map.height == 20
    assert map.width  == 20
    assert map.tilewidth == 32
    assert Enum.count(map.layers) == 4
  end

  test "background layer", context do
    alias TiledMap.Layer, as: TMLayer
    map = context[:map]
    background = TiledMap.get_layer(map, "Background")
    assert background.name == "Background"
    assert TMLayer.tiles?(background)
    assert not TMLayer.objects?(background)

    assert is_tuple(background._data)
    assert tuple_size(background._data) == map.height * map.width

    assert TMLayer.tile_at(background,  0,  0) == 69
    assert TMLayer.tile_at(background,  8,  0) == 83
    assert TMLayer.tile_at(background,  8, 19) == 79
    assert TMLayer.tile_at(background, 19, 19) == 69

    assert_raise ArgumentError, fn ->
      TMLayer.tile_at(background, 20, 20) == 83
    end
  end

  test "entities layer", context do
    map = context[:map]
    ent_layer = TiledMap.get_layer(map, "Entities")
    assert ent_layer.name == "Entities"
    assert TiledMap.Layer.objects?(ent_layer)

    obj_list = ent_layer.objects
    assert length(obj_list) == 4

    [obj|_more_objs] = obj_list
    assert obj.gid == 27
    assert obj.x == 512
    assert obj.y == 480
    assert obj.type == "Player"
    assert obj.properties["multiplayerSpawn"] == true

    assert TiledMap.Object.position(obj) == {512, 480}
    assert TiledMap.Object.size(obj) == {32, 32}
    assert TiledMap.Object.property(obj, "multiplayerSpawn") == true
  end


  test "tile set", context do
    alias TiledMap.TileSet, as: TS
    map = context[:map]
    ts = TiledMap.get_tileset(map, "sprites")
    assert ts.name == "sprites"
    assert ts.firstgid == 1
    assert ts.tilecount == 90
    assert ts.columns   == 10

    assert TS.tile_properties(ts, 26)["multiplayerSpawn"] == true
    assert TS.tile_properties(ts, 30)["type"] == "Key"
    assert TS.tile_properties(ts,"39")["type"] == "Exit"

    [yeldoor, bludoor, reddoor] = 33..35 |> Enum.map(&(TS.tile_properties(ts,&1)))
    assert yeldoor["type"] == "Door"
    assert yeldoor["keyColor"] == "yellow"
    assert bludoor["keyColor"] == "blue"
    assert reddoor["keyColor"] == "red"

    assert TS.tile_properties(ts, 89)["blocked"] == true
  end

end
