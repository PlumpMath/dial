extends Area2D

var mGameState
var mCurrent
var mSound

func _ready():
	mGameState = get_node("/root/GameState")
	mSound = get_node("ExitPlayer")
	set_fixed_process(true)

func _fixed_process(delta):
	if(mGameState.mExitState != mCurrent):
		mCurrent = mGameState.mExitState
		if(mCurrent):
			mSound.play("level_complete_finished")
	
func _exit(area):
	if(mCurrent):
		mGameState.next_scene()
