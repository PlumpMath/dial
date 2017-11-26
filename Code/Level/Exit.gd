extends Area2D

var mGameState

func _ready():
	mGameState = get_node("/root/GameState")
	
func _exit(area):
	var active = true
	for node in get_tree().get_nodes_in_group("Piece"):
		if(not node.mActive):
			active = false
	
	if(active):
		mGameState.next_scene()
