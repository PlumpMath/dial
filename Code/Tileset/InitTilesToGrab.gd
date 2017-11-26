extends TileMap

# For all wall tiles need to set Shape offset to (16,16) and Tex offset to (0,-32)

func _ready():
	self.add_to_group("Grabbable",true)
