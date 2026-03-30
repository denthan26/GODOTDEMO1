extends Area2D

@onready var talk_button = $Label
@onready var storage_panel = $"/root/Node2D/StoragePanel"

func _ready() -> void:
	talk_button.visible = false
	storage_panel.visible = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		talk_button.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		talk_button.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("talk") and talk_button.visible:
		print("按下 F 开始对话！")
		storage_panel.visible = true
		# 暂停玩家移动（可选）
		#get_tree().paused = true
		var player = get_tree().get_first_node_in_group("player")
		player.can_move = false
