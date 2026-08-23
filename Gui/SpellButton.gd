extends GameBaseControl

@onready var button : Button = $"."
@export var spell_id:int

var spell : Spell

func _ready() -> void:
	var spells = player.get_spells()
	if spells and spells.size() >= spell_id+1 :
		spell = spells[spell_id]
		spell.cold_down_change.connect(self._on_cold_down_change)
		button.icon = spell.icon
		button.tooltip_text = spell.name
		_on_applied()
		show()
	else :
		hide()
	options.applied.connect(_on_applied)

func _physics_process(_delta: float) -> void:
	if button.disabled : button.text ="%d:%d" % [ spell.get_time_left()/60, spell.get_time_left()%60 ]
	else : button.text = options.get_input_key_char("spell_%d"%[spell_id+1], KEY_0)

func _on_pressed() -> void:
	player.start_cast_spell(spell)

func _on_cold_down_change(on_cold_down :bool) -> void:
	button.disabled = on_cold_down

func _on_applied() -> void :
	button.text = options.get_input_key_char("spell_%d"%[spell_id+1], KEY_0)
