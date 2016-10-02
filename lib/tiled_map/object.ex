defmodule TiledMap.Object do
  defstruct id: nil, gid: nil,
            name: "", type: "",
            visible: true,
            properties: %{},
            width: 0, height: 0,
            x: 0, y: 0

  # Accessors
  def position(obj),  do: {obj.x, obj.y}
  def size(obj), do: {obj.width, obj.height}
  def property(obj, prop_name), do: obj.properties[prop_name]


end
