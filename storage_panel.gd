extends ColorRect
@onready var close_button = $CloseButton
@onready var vbox = $ScrollContainer/VBoxContainer

# 物品数据（可动态修改）
var items: Array[Dictionary] = [
	{"icon_path": "res://icon.svg", "name": "机床零件", "desc": "用于修复桥梁的零件"},
	{"icon_path": "res://icon.svg", "name": "航空铝材", "desc": "制造飞机框架的材料"},
	{"icon_path": "res://icon.svg", "name": "齿轮组", "desc": "机械核心部件"},
	{"icon_path": "res://icon.svg", "name": "螺丝包", "desc": "通用紧固件"},
	{"icon_path": "res://icon.svg", "name": "钢板", "desc": "建筑用钢板"},
]

func _ready() -> void:
	#visible = false
	close_button.pressed.connect(_on_close_pressed)
	_generate_item_list()
	

func _generate_item_list() -> void:
	
	# 清空旧内容
	for child in vbox.get_children():
		child.queue_free()
	
	# 生成新物品行
	for item in items:
		var item_row = HBoxContainer.new()
		item_row.size = Vector2(600, 80)
		
		# 物品图标
		var icon = TextureRect.new()
		icon.texture = load(item.icon_path)
		icon.size = Vector2(80, 80)
		item_row.add_child(icon)
		
		# 物品描述
		var desc = Label.new()
		desc.text = item.name + "\n" + item.desc
		desc.size = Vector2(420, 80)
		#desc.vertical_alignment = Label.VALIGN_CENTER
		desc.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		item_row.add_child(desc)
		
		# 添加按钮
		var add_btn = Button.new()
		add_btn.text = "添加"
		add_btn.size = Vector2(100, 80)
		add_btn.pressed.connect(func(): _on_add_pressed(item))
		item_row.add_child(add_btn)
		
		vbox.add_child(item_row)
	
func _on_close_pressed() -> void:
	visible = false
	var player = get_tree().get_first_node_in_group("player")
	player.can_move = true
# 添加按钮事件
func _on_add_pressed(item: Dictionary):
	print("添加物品: " + item.name)
	# 这里可实现添加到背包的逻辑
	print(Global.inventory)
	print("添加库存")
	Global.add_item(item)
