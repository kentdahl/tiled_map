defmodule TiledMap.LayerTest do
  use ExUnit.Case
  doctest TiledMap.Layer

  test "load minimal layer" do
    {:ok, map} = TiledMap.parse_json(minimal_map_layer_json_example_str)
    assert Enum.count(map.layers) == 1

    layer = List.first(map.layers)
    assert layer.name == "ground"
    assert Map.size(layer.properties) == 1
    assert layer.properties["tileLayerProp"] == "1"

    assert Enum.count(layer.data) == 16
    assert layer.height * layer.width == 16
  end

  defp minimal_map_layer_json_example_str do
    ~s(
      {
        "layers": [
          {
            "data":[1, 2, 1, 2, 3, 1, 3, 1, 2, 2, 3, 3, 4, 4, 4, 1],
            "height":4,
            "name":"ground",
            "opacity":1,
            "properties":
               {
                "tileLayerProp":"1"
               },
            "type":"tilelayer",
            "visible":true,
            "width":4,
            "x":0,
            "y":0
          }
        ]
      }
    )
  end


  test "load object layer" do
    {:ok, map} = TiledMap.parse_json(minimal_object_layer_json_example_str)
    assert Enum.count(map.layers) == 1

    layer = List.first(map.layers)
    assert layer.name == "people"
    assert layer.type == "objectgroup"
    assert Map.size(layer.properties) == 1
    assert layer.properties["layerProp1"] == "someStringValue"
    assert Enum.count(layer.objects) == 1

    o = List.first(layer.objects)
    assert o.gid == 5
    assert o.id  == 1
    assert o.name == "villager"
    assert o.properties["hp"] == "12"
  end

  defp minimal_object_layer_json_example_str do
    ~s(
      {
        "layers": [
          {
            "draworder":"topdown",
              "height":0,
              "name":"people",
              "objects":[
                {
                  "gid":5,
                  "height":0,
                  "id":1,
                  "name":"villager",
                  "properties":
                  {
                    "hp":"12"
                  },
                  "rotation":0,
                  "type":"npc",
                  "visible":true,
                  "width":0,
                  "x":32,
                  "y":32
                }
              ],
              "opacity":1,
              "properties":
              {
                "layerProp1": "someStringValue"
              },
              "type":"objectgroup",
              "visible":true,
              "width":0,
              "x":0,
              "y":0
          }
        ]
      }
    )
  end

end
