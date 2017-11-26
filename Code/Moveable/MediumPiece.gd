extends "res://Code/Piece/Piece.gd"

export var MOTION_SPEED = 100

func _ready():
	mType = "Medium"
	self.add_to_group(mType)
