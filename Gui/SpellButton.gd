extends GameBaseControl

@onready var button : Button = $"."
@export var spell_id:int

var spell : Spell

func _ready() -> void:
	var spells = player.get_spells()
	if spells and spells.size() >= spell_id+1 :
		spell = spells[spell_id]
		button.icon = spell.icon
		show()
	else :
		hide()

func _on_pressed() -> void:
	
	pass
