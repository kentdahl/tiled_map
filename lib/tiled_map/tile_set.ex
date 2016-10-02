defmodule TiledMap.TileSet do
  defstruct firstgid: nil,
            image: "",
            name: "",
            visible: true,
            properties: %{},
            tilewidth:  0, tileheight:  0, tilecount: 0,
            imagewidth: 0, imageheight: 0,
            margin: 0, spacing: 0, columns: 0,
            tileproperties: %{},
            terrains: [],
            tiles: %{}


  def property(tileset, prop_name), do: tileset.properties[prop_name]

  def tile_properties(tileset, tile_id), do: tileset.tileproperties[to_string(tile_id)]


end
