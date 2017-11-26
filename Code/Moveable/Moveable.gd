extends KinematicBody2D

const NORTH = Vector2(0,-1)
const SOUTH = Vector2(0,1)
const EAST = Vector2(1,0)
const WEST = Vector2(-1,0)
var mDir
var mReel
var mMotionSpeed

func _ready():
	self.add_to_group("Grabbable")
	self.add_to_group("Moveable")
	mReel = false
	mDir = Vector2(0,0)
	mMotionSpeed = self.MOTION_SPEED
	#set_fixed_process(true)
	
func _fixed_process(delta):
	if(mReel and not is_colliding()):
		var m = mDir.normalized()*delta*mMotionSpeed
		move(m)
	if(mReel and is_colliding()):
		mDir = Vector2(0,0)
		mReel = false
	
func reel(collisionDir, speed, delta):
	mDir = get_reel_dir(collisionDir)
	var m = mDir.normalized()*speed*delta
	move(m)
	return(m)

func get_reel_dir(collisionDir):
	if(collisionDir == NORTH):
		return SOUTH
	if(collisionDir == SOUTH):
		return NORTH
	if(collisionDir == EAST):
		return WEST
	if(collisionDir == WEST):
		return EAST