extends Node

const DMF = preload("res://Code/Menu/DynamicMenuFuncs.gd")
var mStart
var mCamera
var mBackground
var mGameState
var mTitle
var mContinue
var mCredits

func _ready():
	mBackground = get_node("AnimatedSprite")
	mStart = get_node("Start")
	mContinue = get_node("Continue")
	mCamera = get_node("Camera2D")
	mCamera.make_current()
	DMF.center_camera_in_sprite(mCamera,mBackground)
	mGameState = get_node("/root/GameState")
	

func _on_Start_pressed():
	mGameState.next_scene()


func _on_Credits_pressed():
	mGameState.play_credits()
