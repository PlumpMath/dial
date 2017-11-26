extends "res://Code/Piece/Piece.gd"

export var MOTION_SPEED = 50

func _ready():
	mType = "Heavy"
	self.add_to_group(mType)
