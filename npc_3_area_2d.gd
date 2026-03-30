extends Area2D

@onready var talk_button = $TalkButton

@onready var dialog_box = $"/root/Node2D/DialogBox2"

# 新增：标记该 NPC 是否已经完成对话
var has_talked: bool = false


func _ready():
	# 初始隐藏对话按钮
	talk_button.visible = false

func _on_body_entered(body: Node2D) -> void:
	# 只对 player 节点生效
	if body.name == "player" and not has_talked :
		talk_button.visible = true  # 显示 F 对话按钮


func _on_body_exited(body: Node2D) -> void:
	if body.name == "player":
		talk_button.visible = false  # 隐藏对话按钮
		
# 监听 F 键输入（也可以单独写在 player 脚本里）
func _input(event):
	if event.is_action_pressed("talk") and talk_button.visible:
		print("按下 F 开始对话！")
		# 这里后续可以写对话逻辑
		dialog_box.start_dialog()
		talk_button.visible = false  # 隐藏对话按钮
		# 监听对话结束事件，标记为已对话
		dialog_box.dialog_finished.connect(_on_dialog_finished)

# 对话结束后执行
func _on_dialog_finished():
	has_talked = true  # 标记为已对话
	talk_button.visible = false  # 确保按钮隐藏
