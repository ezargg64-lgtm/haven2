extends Node2D

var score: int = 0

@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel

func _ready() -> void:
	setup_level()

func setup_level() -> void:
	var apples = $LevelRoot.get_node_or_null("Apples")
	if apples:
		for apple in apples.get_children():
			apple.collected.connect(increase_score)

	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)

func _on_player_died(body: Node2D) -> void:
	body.die()

func increase_score() -> void:
	score += 1
	score_label.text = "Score: %s" % score
