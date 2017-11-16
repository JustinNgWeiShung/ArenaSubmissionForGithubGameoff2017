# Global System functions
extends Node

var gameState
var currentScene
var PlayerName = "Mike"
var CHAR_SELECT_SCENE_NAME="res://stages/char_select.tscn"
var TITLE_SCENE_NAME="res://stages/title.tscn"
var GAME_SCENE_NAME="res://stages/game.tscn"
var P1CHAR="p1"
var P2CHAR="p2"
var p1_char="p1"
var effect = 0;
var debug = false

func getPlayerName():
	return PlayerName;
	
func _ready():
	currentScene = get_tree().get_root().get_child(get_tree().get_root().get_child_count()-1);
	#Globals.set("MAX_POWER_LEVEL",9000)
	
func setScene(scenePath):
	currentScene.queue_free()
	var s = ResourceLoader.load(scenePath)
	currentScene = s.instance()
	get_tree().get_root().add_child(currentScene)

func changeEffect():
	effect+=1;
	if(effect>1):
		effect=0;