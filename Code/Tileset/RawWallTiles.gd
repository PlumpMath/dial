extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	for c in self.get_children():
		if(c.has_node("StaticBody2D")):
			print("Wall")
