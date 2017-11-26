extends Node

const DMF = preload("res://Code/Menu/DynamicMenuFuncs.gd")
var mStart
var mCamera
var mBackground
var mGameState
var mTitle
var mContinue

func _ready():
	var items = Array()
	mBackground = get_node("TextureFrame")
	mTitle = get_node("Title")
	mStart = get_node("Start")
	mContinue = get_node("Continue")
	mCamera = get_node("Camera2D")
	mCamera.make_current()
	DMF.center_camera_in_background(mCamera,mBackground)
	items.append(mTitle)
	items.append(mStart)
	items.append(mContinue)
	DMF.y_position_items(mCamera,items)
	mGameState = get_node("/root/GameState")
	

func _on_Start_pressed():
	mGameState.next_scene()
