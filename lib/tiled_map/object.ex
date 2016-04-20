defmodule TiledMap.Object do
  defstruct id: nil, gid: nil,
            name: "", type: "",
            visible: true,
            properties: %{},
            width: 0, height: 0,
            x: 0, y: 0

end
