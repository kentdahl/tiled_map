defmodule TiledMap do

  @moduledoc """
    Parses a [Tiled JSON map](https://github.com/bjorn/tiled/wiki/JSON-Map-Format)
    as exported by the [Tiled map editor](http://www.mapeditor.org/)
    from file or string.
  """

  defstruct name: "",
            width: 0,
            height: 0,
            layers: [],
            properties: %{},
            backgroundcolor: "#000000",
            orientation: "orthogonal",
            tilesets: [], tilewidth: 0, tileheight: 0,
            renderorder: "",
            version: 1


  def load_json_map(filename) do
    {:ok, file_data } = File.read(filename)
    parse_json(file_data)
  end

  def parse_json(json_str) do
    Poison.decode(json_str,
      as:
        %TiledMap{
          layers: [
            %TiledMap.Layer{
              objects: [%TiledMap.Object{}]
            }
          ],
          tilesets: [%TiledMap.TileSet{}]
        }
      )
  end

  def get_layer(map, layer_name) do
    map.layers
    |> Enum.find(fn layer -> layer.name == layer_name end)
  end

end
