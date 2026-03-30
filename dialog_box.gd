extends ColorRect

# 引用 UI 节点
@onready var left_avatar: TextureRect = $LeftAvatar
@onready var right_avatar: TextureRect = $RightAvatar
@onready var dialog_text: Label = $DialogText

# 对话数据（可自行扩展）
var dialog_list: Array[Dictionary] = [
	{"speaker": "npc", "text": "你好呀，欢迎来到这个小岛！"},
	{"speaker": "npc", "text": "这里的机床还能用吗？我需要你帮我修桥。"},
	{"speaker": "player", "text": "我会尽力的，先告诉我需要做什么吧。"},
	{"speaker": "npc", "text": "先收集零件，然后去东边的机床加工。"},
]
var current_index: int = 0

func _ready():
	# 初始隐藏对话框
	visible = false
	left_avatar.visible = false
	right_avatar.visible = false

# 开始对话
func start_dialog():
	visible = true
	current_index = 0
	show_next_dialog()

# 显示下一句对话
func show_next_dialog():
	if current_index >= dialog_list.size():
		end_dialog()
		return
	
	var data = dialog_list[current_index]
	dialog_text.text = data.text
	
	# 显示对应头像
	if data.speaker == "npc":
		left_avatar.visible = true
		right_avatar.visible = false
	elif data.speaker == "player":
		left_avatar.visible = false
		right_avatar.visible = true
	
	current_index += 1

# 结束对话
func end_dialog():
	visible = false
	left_avatar.visible = false
	right_avatar.visible = false
	dialog_text.text = ""

# 监听鼠标左键点击，推进对话
func _input(event):
	if visible and event.is_action_pressed("left_click"):
		show_next_dialog()
