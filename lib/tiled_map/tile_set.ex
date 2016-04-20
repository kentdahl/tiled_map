defmodule TiledMap.TileSet do
  defstruct firstgid: nil,
            image: "",
            name: "",
            visible: true,
            properties: %{},
            tilewidth:  0, tileheight:  0,
            imagewidth: 0, imageheight: 0,
            margin: 0, spacing: 0,
            tileproperties: %{},
            terrains: [],
            tiles: %{}

end
