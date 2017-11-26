extends Panel

var p1SelectionBox
var p1Portrait
var p2Portrait
var actionLock=false
var selectLock=false
var p2ModeLock=false
var p1SelectedPortrait
var p2ModeIndicator
var transitionLock=false

func _ready():
	GLOBAL_SYS.gameTransitionNumber=0
	p1SelectionBox = get_node("p1Selection")
	
	p2ModeIndicator = get_node("p2ModeIndicator")
	
	p1Portrait= get_node("p1Button")
	p2Portrait= get_node("p2Button")
	_setSelectionBoxPos("p1",p1Portrait);
	set_process(true);
	
	pass
	
func _setSelectionBoxPos(playerID,portrait):
	var selectionBox
	if(playerID == "p1"):
		p1SelectedPortrait=portrait
		selectionBox=p1SelectionBox
	
	var newPos = Vector2(portrait.get_pos().x+
							(selectionBox.get_item_rect().size.x*selectionBox.get_scale().x)/2* portrait.get_scale().x
							,portrait.get_pos().y+(selectionBox.get_item_rect().size.y*selectionBox.get_scale().y)/2);
	selectionBox.set_pos(newPos);
	
func _process(delta):
	if(transitionLock):
		return
	_effectCheck()
	_playerInputCheck()
	
	if(GLOBAL_SYS.p2ModeEnable):
		p2ModeIndicator.show()
	else:
		p2ModeIndicator.hide()
	
	GLOBAL_INPUT.quitGame();
	#if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
		#print(str("Mouse Button pressed at: ", get_global_mouse_pos()));
		
	pass
	
func _effectCheck():
	GLOBAL_INPUT.changeEffect();
	
	if(GLOBAL_SYS.effect == 0):
		get_node("overlay").hide()
	else:
		get_node("overlay").show()
		
func _playerInputCheck():
	
	if(p1SelectedPortrait==p1Portrait):
		if((Input.is_action_pressed("P1_MOVE_RIGHT") || Input.is_action_pressed("P1_MOVE_LEFT")) && !actionLock):
			_setSelectionBoxPos("p1",p2Portrait)
			get_node("SamplePlayer").play("select")
	else:
		if((Input.is_action_pressed("P1_MOVE_RIGHT") || Input.is_action_pressed("P1_MOVE_LEFT")) && !actionLock):
			_setSelectionBoxPos("p1",p1Portrait)
			get_node("SamplePlayer").play("select")
	
	if((Input.is_action_pressed("P1_ATTACK") || Input.is_action_pressed("P1_START") || Input.is_action_pressed("P1_JUMP"))  && !selectLock):
		p1SelectedPortrait.pressed()
		get_node("SamplePlayer").play("select")
		transitionLock=true
		
	if(Input.is_action_pressed("P2_START") && !p2ModeLock):
		GLOBAL_SYS.p2ModeEnable=true
		
	selectLock = Input.is_action_pressed("P1_ATTACK") || Input.is_action_pressed("P1_START") || Input.is_action_pressed("P1_JUMP")
	actionLock = Input.is_action_pressed("P1_MOVE_RIGHT") || Input.is_action_pressed("P1_MOVE_LEFT")
	p2ModeLock = Input.is_action_pressed("P2_START")
	