extends "res://Code/Piece/Piece.gd"

export var MOTION_SPEED = 300

func _ready():
	mType = "Light"
	self.add_to_group(mType)
	

