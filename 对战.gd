extends Node2D

onready var card=$"游戏发牌功能/手牌"
#怪物回合结束信号
signal monster_end
#指针点到的敌人节点
#var _enemy
#经过回合
var turn:int
#加载敌人节点
var monsters=Game.monster
#一次的伤害
var damage:int

func _ready():
	for x in monsters:
		x.name="monster"
		x.position=Vector2(1450,430)
		self.add_child(x)
		x.connect("die",self,"monster_die",[x])
	$"主角".connect("blood",self,"blood_change")
#卡牌使用计算	
func _on__attack(enemy):
	#_enemy=enemy
	if card.use_card != null:
		print("ack")
		#伤害计算
		enemy.get_children()[0].value-=card.use_card.damage
		#伤害飘字
		$"伤害飘字".position=enemy.get_parent().position
		$"伤害飘字".show_value(card.use_card.damage,false)
		#调用敌我buff计算
		if card.use_card.effect:
			for x in card.use_card.effect:
				Game.creat_buff(x,card.use_card.rounds,true)
				if !Game.buff.empty():
					$"主角/buff".add_child(Game.buff[0])
					#!!!!!刷新卡面数值
					pai_mian_xiu_gai()
				for buff in $"主角/buff".get_children():
					buff.refresh(true)
		if card.use_card.de_effect:
			for x in card.use_card.de_effect:
				Game.creat_buff(x,card.use_card.de_rounds,false)
				if !Game.buff.empty():
					enemy.get_children()[1].add_child(Game.buff[0])
				for buff in enemy.get_children()[1].get_children():
					buff.refresh(false)
		$"主角".anim(true)
		#弃牌堆和牌库计算
		$"游戏发牌功能/弃牌堆".discard(card.use_card.duplicate())
		var delete=card.use_card.get_parent().get_parent()
		delete.queue_free()
		card.my_card.erase(card.use_card)
		card.use_card=null
		$"箭头".visible=false
		card.state=card.states.wait_choose
		card.hold_card.erase(delete)	
		card.refresh()
#我方回合结束，到对方回合
func _on__round_end():
	#自己的buff结算
	var del_buff=[]
	var del_debuff=[]
	for key in Game.self_buff:
		Game.self_buff[key]-=1
		for buff in $"主角/buff".get_children():
			buff.refresh(true)
		if Game.self_buff[key]==0:
			del_buff.append(key)
			#牌面修改!!!!!!!!!!!
			pai_mian_xiu_gai()
	for x in del_buff:
		Game.self_buff.erase(x)

		
	#怪物行为
	for x in monsters:
		x.state(turn)
		x.anim()
		$"主角".anim(false)
		damage=x.hit*doBuff.enemy_Attack_rate
		$"主角/blood".value-=x.hit_frequency*damage
		#伤害飘字
		$"伤害飘字".position=$"主角".position
		for frequency in x.hit_frequency:			
			$"伤害飘字".show_value(damage,false)
	#buff and debuff
	#[["狂怒",2],["虚弱",3]]
		if x.buff:
			for number in x.buff.size():
				Game.creat_buff(x.buff[number][0],x.buff[number][1],true)
				if !Game.buff.empty():
					$"主角/buff".add_child(Game.buff[0])
				for buff in $"主角/buff".get_children():
					buff.refresh(true)
		if x.debuff:
			for number in x.debuff.size():
				Game.creat_buff(x.debuff[number][0],x.debuff[number][1],false)
				if !Game.buff.empty():
					x.get_children()[1].get_children()[1].add_child(Game.buff[0])
				for buff in x.get_children()[1].get_children()[1].get_children():
					buff.refresh(false)
					
	#对方的buff结算
	for monster in monsters:
		for key in Game.enemy_buff:
			Game.enemy_buff[key]-=1
			if Game.enemy_buff[key]==0:
				del_debuff.append(key)
		for buff in monster.get_children()[1].get_children()[1].get_children():
			buff.refresh(false)
		for x in del_debuff:
			Game.enemy_buff.erase(x)
	
	
	yield(get_tree().create_timer(1),"timeout")
	emit_signal("monster_end")

#怪物死亡
func monster_die(guai_wu):
	Game.monster.erase(guai_wu)
	guai_wu.queue_free()
	if Game.monster.empty():
		$"箭头".queue_free()
		$"游戏发牌功能/AnimationPlayer".play("结束")
		yield($"游戏发牌功能/AnimationPlayer","animation_finished")
		var Chest=load("res://奖励/宝箱.tscn").instance()
		Chest.initialization(Game.weight)
		self.add_child(Chest)
#		Game.clear()
#		pai_mian_xiu_gai()

#牌面修改!!!!!!!!!!!
func pai_mian_xiu_gai():
	for card in Game.cards:
		card.refresh()
	$"游戏发牌功能/手牌".card_refresh()
	$"游戏发牌功能/弃牌堆".card_refresh()

#抬头栏血量
func blood_change(value):
	$"抬头栏/心/health".text=str(value)+"/"+"100"
