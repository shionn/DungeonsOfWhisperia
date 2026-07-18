extends GameBase3D

@onready var _skull1 = $wall_inset3/Skull
@onready var _skull2 = $wall_inset4/Skull
@onready var _skull3 = $wall_inset5/Skull
@onready var _skull4 = $wall_inset6/Skull


func _on_skull_state_change() -> void:
	print("Truc")
	if _skull1.state and _skull2.state and _skull3.state and _skull4.state and $Secret/Closed.visible:
		gui.openTransition(_openSecret)
		gui._close()

func _openSecret() -> void:
	$Secret/Closed.hide()
	$Secret/Open.show()
	$Secret/AudioStreamPlayer3D.play()
	
