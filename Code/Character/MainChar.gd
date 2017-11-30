extends KinematicBody2D

#how to add/remove between layers
#self.set_collision_mask_bit(0,false)
#self.set_layer_mask_bit(0,false)

export var MOTION_SPEED = 100
var mRay
var mCurAnim
var mAnimPlayer
var mGrapple
var mPackedGrapple
var mHeart
var mGameState
var mExit
var mAttractor

func _ready():
	mRay = get_node("RayCast2D")
	mCurAnim = "right_idle"
	mAnimPlayer = get_node("AnimationPlayer")
	mGrapple = get_node("Grapple")
	mPackedGrapple = load("res://Code/Character/Grapple.tscn")
	mHeart = get_node("AreaHeart")
	mGameState = get_node("/root/GameState")
	mExit = get_node("../Exit")
	mAttractor = get_node("ParticleAttractor2D")
	mHeart.connect("area_enter",mExit,"_exit")
	mGameState.mExitState = false
	set_fixed_process(true)
	
func die():
	mGameState.level_reset()
	
func set_grapple_bits():
	self.set_collision_mask_bit(0,false)
	self.set_layer_mask_bit(0,false)
	mHeart.set_collision_mask_bit(1,false)
	mHeart.set_layer_mask_bit(1,false)
	
func set_walk_bits():
	self.set_collision_mask_bit(0, true)
	self.set_layer_mask_bit(0, true)
	mHeart.set_collision_mask_bit(1, true)
	mHeart.set_layer_mask_bit(1, true)

func get_shoot_anim():
	var playingAnim = mAnimPlayer.get_current_animation()
	if(mRay.get_rotd() == 180):
		return "up_shoot"
	elif(mRay.get_rotd() == 0):
		return "down_shoot"
	elif(mRay.get_rotd() == 90):
		return "right_shoot"
	elif(mRay.get_rotd() == -90):
		return "left_shoot"
	else:
		print("get_shoot_anim last case should never occur")

func reset_grapple():
	remove_child(mGrapple)
	get_parent().add_child(mGrapple)
	mGrapple.call_deferred("queue_free")
	var newGrapple = mPackedGrapple.instance()
	add_child(newGrapple)
	mGrapple = newGrapple
	# set_particles causes many debug errors to occur, but no memory leak
	# delay resolving these errors.
	mAttractor.set_particles_path("../Grapple/Particles2D")

func _fixed_process(delta):
	var motion = Vector2(0,0)
	var overlap = mHeart.get_overlapping_bodies()
	if(overlap.size()>0):
		die()
	if(mGrapple.mActive):
		if(Input.is_action_pressed("ui_ctrl")):
			mGrapple.reset()
		return
	
	if(Input.is_action_pressed("ui_up")):
		motion += Vector2(0,-1)
		mRay.set_rotd(180)
		mCurAnim = "up_walk"
	elif(mCurAnim == "up_walk"):
		mCurAnim = "up_idle"
	if(Input.is_action_pressed("ui_down")):
		motion += Vector2(0,1)
		mRay.set_rotd(0)
		mCurAnim = "down_walk"
	elif(mCurAnim == "down_walk"):
		mCurAnim = "down_idle"
	if(Input.is_action_pressed("ui_right")):
		motion += Vector2(1,0)
		mRay.set_rotd(90)
		mCurAnim = "right_walk"
	elif(mCurAnim == "right_walk"):
		mCurAnim = "right_idle"
	if(Input.is_action_pressed("ui_left")):
		motion += Vector2(-1,0)
		mRay.set_rotd(-90)
		mCurAnim = "left_walk"
	elif(mCurAnim == "left_walk"):
		mCurAnim = "left_idle"
		
	if(Input.is_action_pressed("ui_shoot")):
		mGrapple.fire(mRay.get_rotd())
		mCurAnim = get_shoot_anim()
		motion = Vector2(0,0)
		
	if(mAnimPlayer.get_current_animation() != mCurAnim):
		mAnimPlayer.play(mCurAnim)
	
	var normMotion = motion.normalized()*MOTION_SPEED*delta
	
	if(is_colliding()):
		var collider = get_collider()
		if(collider.is_in_group("Moveable")):
			var newSpeed = min(self.MOTION_SPEED,collider.MOTION_SPEED)
			normMotion = motion.normalized()*newSpeed*delta
			collider.move(normMotion)
	
	move(normMotion)


func _on_ParticleAttractor2D_exit_tree():
	pass # replace with function body
