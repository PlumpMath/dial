extends Node

var mLevelNum
var mLevelStr
var mSceneNum
var mSound
const LEVEL_PREFIX = "res://Code/Level/Level";
const STORY_PREFIX = "res://Code/StoryBoard/Story"
var mSceneArray = Array()

func _ready():
	mSceneNum = -1
	var soundPacked = preload("res://Code/Singletons/SamplePlayer.tscn")
	mSound = soundPacked.instance()
	self.add_child(mSound)
	mSound.play("clock_music_finished_smp")
	mSceneArray.append(STORY_PREFIX+"00.tscn")
	mSceneArray.append(STORY_PREFIX+"01.tscn")
	mSceneArray.append(STORY_PREFIX+"02.tscn")
	mSceneArray.append(STORY_PREFIX+"03.tscn")
	mSceneArray.append(LEVEL_PREFIX+"00.tscn")
	mSceneArray.append(LEVEL_PREFIX+"01.tscn")
	mSceneArray.append(LEVEL_PREFIX+"02.tscn")
	mSceneArray.append(LEVEL_PREFIX+"03.tscn")

func start_game():
	get_tree().change_scene(mLevelStr)

func get_level_str(level_num):
	if(level_num < 10):
		return(LEVEL_PREFIX+"0"+str(level_num)+".tscn")
	return LEVEL_PREFIX+str(level_num)+".tscn"
	
func level_reset():
	get_tree().change_scene(mSceneArray[mSceneNum])
	
func next_level():
	mLevelNum += 1
	mLevelStr = get_level_str(mLevelNum)
	get_tree().change_scene(mLevelStr)
	
func next_scene():
	mSceneNum += 1
	if(mSceneNum >= mSceneArray.size()):
		mSceneNum = 0
		get_tree().change_scene("res://Code/Menu/MainMenu.tscn")
	else:
		get_tree().change_scene(mSceneArray[mSceneNum])
