
static func calc_spacer(camera, itemList):
	var itemTotalSize = get_item_size_sum(itemList)
	var cameraSize = camera.get_viewport_rect().size
	var spacer = (cameraSize-itemTotalSize)/itemList.size()
	return spacer

static func y_position_items(camera, itemList):
	var cameraSize = camera.get_viewport_rect().size
	var itemTotalSize = get_item_size_sum(itemList)
	var spacer = calc_spacer(camera, itemList)
	spacer.x = 0
	var toSetPos = camera.get_pos()
	toSetPos.y -= (cameraSize.y/2)
	toSetPos.y += (itemList[0].get_size().y/2)
	var constantX = toSetPos.x 
	for i in itemList:
		var newItemCenter = toSetPos
		newItemCenter.x = constantX
		i.set_pos(get_pos_at_center(newItemCenter, i.get_size(), i.get_pos()))
		toSetPos = newItemCenter + spacer
	
static func get_item_size_sum(itemList):
	var toReturn = Vector2(0,0)
	for i in itemList:
		toReturn += i.get_item_rect().size
	return(toReturn)
		
static func center_camera_in_background(camera, background):
	var backgroundCenter = (background.get_size() - background.get_pos())/2
	var cameraCenter = camera.get_camera_screen_center()
	var offset = backgroundCenter - cameraCenter
	camera.set_global_pos(camera.get_pos()+offset)
	
static func get_pos_at_center(centerToSet, objSize, objTopLeftPos):
	var objCenter = (objSize/2)+objTopLeftPos
	var offset = centerToSet - objCenter
	return(objTopLeftPos+offset)

static func set_item_bottom_left(camera, item):
	var cameraSize = camera.get_viewport_rect().size
	var cameraPos = camera.get_pos()
	var newPos = cameraPos
	newPos.y += (cameraSize.y/2)
	newPos.x -= (cameraSize.x/2)
	var itemSize = item.get_item_rect().size
	newPos.y -= itemSize.y
	item.set_pos(newPos)
	
static func set_item_bottom_right(camera, item):
	var cameraSize = camera.get_viewport_rect().size
	var newPos = camera.get_camera_pos()
	newPos = (camera.get_pos()+cameraSize/2)
	newPos -= item.get_item_rect().size
	item.set_pos(newPos)
	

