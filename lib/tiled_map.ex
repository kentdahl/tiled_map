defmodule TiledMap do
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
    data = Poison.decode(json_str,
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
end
