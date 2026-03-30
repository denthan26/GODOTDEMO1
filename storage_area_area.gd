extends Area2D
@onready var talk_button = $TalkButton

func _ready() -> void:
	talk_button.visible = false
	
func _on_body_entered(body: Node2D) -> void:
	# 只对 player 节点生效
	if body.name == "player":
		talk_button.visible = true  # 显示 F 对话按钮


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		talk_button.visible = false  # 隐藏对话按钮
		
# 监听 F 键输入（也可以单独写在 player 脚本里）
func _input(event):
	if event.is_action_pressed("talk") and talk_button.visible:
		print("按下 F 开始对话！")
		# 这里后续可以写对话逻辑
