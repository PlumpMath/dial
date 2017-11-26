extends KinematicBody2D

#how to add/remove between layers
#self.set_collision_mask_bit(0,false)
#self.set_layer_mask_bit(0,false)

# Grapple lives on the collison layer 10th bit, value 2^10
export var MOTION_SPEED = 300
const MAX_DISTANCE = 300
var mRay
var mAnimPlayer
var mActive
var mDir
var mAnimPrefix
var mChar
var mHasCollided
var mCollisionSuffix
var mCollisionObj
var mParticles

func _ready():
	mRay = get_node("RayCast2D")
	mAnimPlayer = get_node("AnimationPlayer")
	mParticles = get_node("Particles2D")
	mActive = false
	mDir = Vector2(0,0)
	mChar = get_parent()
	set_hidden(true)
	set_fixed_process(true)

func _fixed_process(delta):
	if(mChar.get_name() != "MainChar"):
		#handling race likely race condition.
		print("Race Condition Handled.")
		return
	var grapplePos = self.get_global_pos()
	var charPos = mChar.get_global_pos()
	var grappleMotion = mDir.normalized()*MOTION_SPEED*delta
	if(!mActive):
		return
	if(not mHasCollided and grapplePos.distance_to(charPos) > MAX_DISTANCE):
		mCollisionSuffix = "_miss"
		mAnimPlayer.play(mAnimPrefix+mCollisionSuffix)
		mHasCollided = true
		mDir = Vector2(0,0)
		
	if(not mHasCollided and is_colliding()):
		mHasCollided = true
		var bodyObj = get_collider()
		mCollisionObj = bodyObj
		var animSuffix
		if(bodyObj.is_in_group("Grabbable")):
			mCollisionSuffix = "_hit"
		else:
			mCollisionSuffix = "_miss"
		mAnimPlayer.play(mAnimPrefix+mCollisionSuffix)
		mChar.set_grapple_bits()
		
	if(mHasCollided):
		if(!mAnimPlayer.is_playing() and mCollisionSuffix == "_miss"):
			reset()
		elif(!mAnimPlayer.is_playing() and mCollisionSuffix == "_hit"):
			if(mCollisionObj.is_in_group("Moveable")):
				var speedRatio = calc_speed_ratio(mChar.MOTION_SPEED,mCollisionObj.MOTION_SPEED)
				var charSpeed = calc_speed(speedRatio,MOTION_SPEED)
				var objSpeed = calc_inv_speed(speedRatio,MOTION_SPEED)
				mChar.move(mDir.normalized()*charSpeed*delta)
				var reelDelta = mCollisionObj.reel(mDir,objSpeed,delta)
				grappleMotion = grappleMotion * Vector2(-1,-1)
			else:
				mChar.move(grappleMotion)
				grappleMotion = grappleMotion * Vector2(-1,-1)
			if(mChar.is_colliding()):
				reset()

	move(grappleMotion)
	
func activate_collision():
	set_collision_mask_bit(3,true)
	set_layer_mask_bit(3,true)
	
func disable_collision():
	set_collision_mask_bit(3,false)
	set_layer_mask_bit(3,false)
	
func calc_speed_ratio(charSpeed, collisionSpeed):
	return float(charSpeed)/float(collisionSpeed+charSpeed)
	
func calc_speed(ratio, speed):
	return int(ratio*float(speed))

func calc_inv_speed(ratio,speed):
	var inv = 1.0-ratio
	return int(inv*speed)

func reset():
	mChar.set_walk_bits()
	mChar.reset_grapple()

func fire(charRot):
	self.set_hidden(false)
	activate_collision()
	mRay.set_rotd(charRot)
	mActive = true
	if(charRot == 0):
		mDir = Vector2(0,1)
		mAnimPrefix = "down"
	elif(charRot == 180):
		mDir = Vector2(0,-1)
		mAnimPrefix = "up"
	elif(charRot == 90):
		mDir = Vector2(1,0)
		mAnimPrefix = "right"
	elif(charRot == -90):
		mAnimPrefix = "left"
		mDir = Vector2(-1,0)
	mAnimPlayer.play(mAnimPrefix+"_shoot")

func _on_Particles2D_exit_tree():
	pass # replace with function body
