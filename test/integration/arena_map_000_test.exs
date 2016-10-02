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
    map = context[:map]
    background = TiledMap.get_layer(map, "Background")
    assert background.name == "Background"
    assert TiledMap.Layer.tiles?(background)
    assert not TiledMap.Layer.objects?(background)

    assert is_tuple(background._data)
    assert tuple_size(background._data) == map.height * map.width

    assert TiledMap.Layer.tile_at(background,  0,  0) == 69
    assert TiledMap.Layer.tile_at(background,  8,  0) == 83
    assert TiledMap.Layer.tile_at(background,  8, 19) == 79
    assert TiledMap.Layer.tile_at(background, 19, 19) == 69

    assert_raise ArgumentError, fn ->
      TiledMap.Layer.tile_at(background, 20, 20) == 83
    end
  end

  test "entities layer", context do
    map = context[:map]
    ent_layer = TiledMap.get_layer(map, "Entities")
    assert ent_layer.name == "Entities"
    assert TiledMap.Layer.objects?(ent_layer)

    obj_list = ent_layer.objects
    assert length(obj_list) == 4

    [obj|more_objs] = obj_list
    assert obj.gid == 27
    assert obj.x == 512
    assert obj.y == 480
    assert obj.type == "Player"
    assert obj.properties["multiplayerSpawn"] == true

    assert TiledMap.Object.position(obj) == {512, 480}
    assert TiledMap.Object.size(obj) == {32, 32}
    assert TiledMap.Object.property(obj, "multiplayerSpawn") == true
  end


end
