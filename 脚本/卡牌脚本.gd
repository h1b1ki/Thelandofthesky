extends Control

export var damage:int
export var effect:Array
export var defense:int
export var rounds:int
export var de_effect:Array
export var de_rounds:int
export var describe:String
export var quality:String
export var old_damage:int

#初始化
func initialization(data:Array):
	#4 0 虚弱 技能 0 0 使敌人虚弱~回合 红色 白色 2 1^2 5 2 无
	#改牌的底色
	
	#名称
	$"名称".text=data[2]
	#类型
	
	#攻击数值
	damage=data[4].to_int()
	old_damage=damage
	#防御数值
	defense=data[5].to_int()
	#描述
	$"描述".bbcode_text=data[6].replace("^",damage).replace("~",data[11])
	describe=data[6]
	#牌色
	#品质
	quality=data[8]
	#buff
	if data[9]!="":
		var effects=(data[9].split("^"))
		for x in effects:
			var xiaoguo=preload("res://卡牌/效果详细模板.tscn").instance()
			x=x.to_int()
			effect.append(x)
			xiaoguo.initialization(BuffDatabase.get_data(x))
			$VBoxContainer.add_child(xiaoguo)
	#buff回合
	rounds=data[11].to_int()
	#debuff
	if data[10]!="":
		var de_effects=(data[10].split("^"))
		for x in de_effects:
			var xiaoguo=preload("res://卡牌/效果详细模板.tscn").instance()
			x=x.to_int()
			de_effect.append(x)
			xiaoguo.initialization(BuffDatabase.get_data(x))
			$VBoxContainer.add_child(xiaoguo)
	#debuff回合
	de_rounds=data[12].to_int()
	#图片
	$"图片".texture=load("res://素材/"+data[14]);
	#能量
	$"消耗".text=data[1]

func refresh():
	damage=(old_damage+doBuff.ATK)*doBuff.Attack_rate
	if damage>old_damage:
		$"描述".bbcode_text=describe.replace("^","[color=#FFD700]"+str(damage)+"[/color]")
	elif damage<old_damage:
		$"描述".bbcode_text=describe.replace("^","[color=#FF0000]"+str(damage)+"[/color]")
	else:
		$"描述".bbcode_text=describe.replace("^",str(damage))
func _on__mouse_entered():
#	print(xiaoguo.rect_min_size)
#	print(xiaoguo.get_children()[0])
#	print(xiaoguo.get_children()[0].rect_size)
	$VBoxContainer.visible=true

func _on__mouse_exited():
	$VBoxContainer.visible=false

