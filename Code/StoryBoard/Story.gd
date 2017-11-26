extends Node

const DMF = preload("res://Code/Menu/DynamicMenuFuncs.gd")
var mGameState
var mBackground
var mCamera
var mTimer

func _ready():
	mCamera = get_node("Camera2D")
	mCamera.make_current()
	mGameState = get_node("/root/GameState")
	mBackground = get_node("TextureFrame")
	mTimer = get_node("Timer")
	mTimer.start()
	DMF.center_camera_in_background(mCamera,mBackground)

func _on_Timer_timeout():
	mGameState.next_scene()
