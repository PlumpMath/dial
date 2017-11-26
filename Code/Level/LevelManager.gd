extends Node

var mLevelNum
var mLevelStr
var mLevelNode
var mLevelPacked
var mGameState
const LEVEL_PREFIX = "res://Code/Level/Level";

func _ready():
	mGameState = get_node("/root/GameState")
	mLevelNum = 0
	mLevelStr = get_level_str(mLevelNum)
	print(mLevelStr)
	mLevelPacked = load(mLevelStr)
	mLevelNode = mLevelPacked.instance()
	print(mLevelNode)
	add_child(mLevelNode)
	
func get_level_str(level_num):
	if(level_num < 10):
		return(LEVEL_PREFIX+"0"+str(level_num)+".tscn")
	return LEVEL_PREFIX+str(level_num)+".tscn"
	
func level_reset():
	remove_child(mLevelNode)
	mLevelNode.call_deferred("queue_free")
	mLevelNode = mLevelPacked.instance()
	add_child(mLevelNode)
	
func next_level():
	mLevel += 1
	mLevelStr = get_level_str(mLevel)
	mLevelPacked = load(mLevelStr)
	mLevelnode = mLevelPacked.instance()
	add_child()	