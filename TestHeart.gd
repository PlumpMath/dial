extends KinematicBody2D

export var MOTION_SPEED = 140

func _ready():
	print("Heart Ready")
	set_fixed_process(true)
	
func _fixed_process(delta):
	if(is_colliding()):
		print("Heart Collision")
