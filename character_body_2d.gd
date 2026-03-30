extends CharacterBody2D

@export var speed: float = 300.0

func _physics_process(delta: float) -> void:
	# 获取按键输入
	var input_dir: Vector2 = Vector2.ZERO
	# 一负一正
	input_dir.x = Input.get_axis("left", "right")
	input_dir.y = Input.get_axis("up", "down")
	
	# print(input_dir)

	# 归一化方向（防止斜向移动速度过快）
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
	
	# 设置速度并移动
	velocity = input_dir * speed
	# 移动角色
	move_and_slide()
