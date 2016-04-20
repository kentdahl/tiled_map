defmodule TiledMap.Layer do
  defstruct name: "", type: "",
            data:    [],   # filled for "tilelayer" type
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

end
