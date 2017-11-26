extends "res://Code/Moveable/Moveable.gd"

var mAnim
var mArea
var mActive
var mType

func _ready():
	mAnim = get_node("AnimationPlayer")
	mArea = get_node("Area2D")
	mActive = false
	mType = "Piece"
	mArea.connect("area_enter",self,"_area_enter_is_match")
	mArea.connect("area_exit",self,"_area_exit_is_match")
	self.add_to_group("Piece")
	
func _area_enter_is_match(area):
	if(area.is_in_group(mType)):
		mAnim.play("active")
		mActive = true
	
func _area_exit_is_match(area):
	if(area.is_in_group(mType)):
		mAnim.stop_all()
		mActive = false