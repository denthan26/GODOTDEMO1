extends ColorRect

# 新增：定义对话结束信号
signal dialog_finished

# 引用 UI 节点
@onready var left_avatar: TextureRect = $LeftAvatar
@onready var right_avatar: TextureRect = $RightAvatar
@onready var dialog_text: Label = $DialogText
@onready var option1: Button = $Option1
@onready var option2: Button = $Option2

# 对话数据
var dialog_list: Array[Dictionary] = [
	{"speaker": "npc", "text": "你好，我有个问题想问问你。"},
	{
		"speaker": "npc",
		"text": "你觉得我们应该先修桥还是先造飞机？",
		"options": [
			{"text": "先修桥", "next": 3},
			{"text": "先造飞机", "next": 5}
		]
	},
	{"speaker": "player", "text": "我觉得先修桥更稳妥。"},
	{"speaker": "npc", "text": "没错，桥通了才能运材料！"},
	{"speaker": "player", "text": "先造飞机吧，更快离开这里。"},
	{"speaker": "npc", "text": "有魄力！那我们先收集航空零件。"}
]
var current_index: int = 0
var is_waiting_for_option: bool = false  # 是否在等待玩家选选项

func _ready():
	visible = false
	left_avatar.visible = false
	right_avatar.visible = false
	option1.visible = false
	option2.visible = false

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
	
	# 处理选项
	if data.has("options"):
		is_waiting_for_option = true
		# 显示选项按钮
		option1.text = data.options[0].text
		option2.text = data.options[1].text
		option1.visible = true
		option2.visible = true
		# 绑定选项点击事件
		option1.pressed.connect(func(): on_option_selected(0))
		option2.pressed.connect(func(): on_option_selected(1))
	else:
		is_waiting_for_option = false
		option1.visible = false
		option2.visible = false
		current_index += 1

# 玩家选择选项后
func on_option_selected(option_idx: int):
	var data = dialog_list[current_index]
	current_index = data.options[option_idx].next  # 跳转到指定对话
	option1.visible = false
	option2.visible = false
	is_waiting_for_option = false
	show_next_dialog()

# 结束对话
func end_dialog():
	visible = false
	left_avatar.visible = false
	right_avatar.visible = false
	option1.visible = false
	option2.visible = false
	dialog_text.text = ""
	is_waiting_for_option = false
	dialog_finished.emit()

# 监听鼠标点击（只有非选项时才推进）
func _input(event):
	if visible and event.is_action_pressed("left_click") and not is_waiting_for_option:
		show_next_dialog()
