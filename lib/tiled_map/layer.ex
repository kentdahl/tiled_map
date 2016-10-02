defmodule TiledMap.Layer do
  defstruct name: "", type: "",
            data:    [],   # filled for "tilelayer" type
            _data:   {},   # private; tuple version of `data` list for O(1) access
            objects: [],   # filled for "objectgroup" type
            opacity: 1,
            properties: %{},
            width: 0, height: 0,
            x: 0, y: 0

  def tiles?(layer) do
    layer.type == "tilelayer"
  end

  def objects?(layer) do
    layer.type == "objectgroup"
  end

  def tile_at(%{_data: tupdata, width: w, type: "tilelayer"}, x,y) do
    elem(tupdata, x + y * w)
  end

end

defimpl Poison.Decoder, for: TiledMap.Layer do
  def decode(value, options) do
    %{value|_data: List.to_tuple(value.data)}
  end
end
