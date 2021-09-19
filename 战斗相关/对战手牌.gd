extends Node2D

var play=false
onready var arrow=$"../箭头"
#onready var use_card=
signal round_end

func _ready():
	$AnimationPlayer.play("开始")
	yield($AnimationPlayer,"animation_finished")
	#从牌库中获得牌   cards是牌节点的数组
	var cards=$"牌库".get_card(Game.Draw)
	#发牌
	$"手牌".start(cards)

#点击卡片
func _on__click(card):
	arrow.visible=true
	$"../箭头/Node2D".global_position=card.rect_global_position-Vector2(-70,-50)
	play=true

func _physics_process(delta):
	if play ==true&&Input.is_action_just_pressed("右键按下"):
		arrow.visible=false
		$"手牌".Homing()
		play=false

#使用手牌
#func _on__attack(enemy):
#	if $"手牌".use_card != null:
#		print("ack")
#		#伤害计算
#		enemy.get_children()[0].value-=$"手牌".use_card.damage
#		#buff计算
#		if $"手牌".use_card.effect:
#			for x in $"手牌".use_card.effect.size():
#				Game.creat_buff($"手牌".use_card.effect[x],$"手牌".use_card.rounds)
#				enemy.get_children()[1].add_child(Game.buff[0])
#
#		#弃牌堆和牌库计算
#		$"弃牌堆".discard($"手牌".use_card.duplicate())
#		var delete=$"手牌".use_card.get_parent().get_parent()
#		delete.queue_free()
#		$"手牌".use_card=null
#		arrow.visible=false
#		$"手牌".state=$"手牌".states.wait_choose
#		$"手牌".hold_card.erase(delete)
#		$"手牌".refresh()
#


#回合结束按钮
func _on__button_down():
	if $"手牌".state==$"手牌".states.wait_choose:
		for x in $"手牌/Path2D".get_children():
			$"弃牌堆".discard(x.get_children()[0].get_children()[0].duplicate())
			x.queue_free()
		$"手牌".state=$"手牌".states.cards_zero
		$"手牌".refresh()
		$"手牌".hold_card.clear()
		$"手牌".my_card.clear()
		#敌方回合
		emit_signal("round_end")
		yield($".".get_parent(),"monster_end")
		#从牌库中获得牌   cards是牌节点的数组
		var cards=$"牌库".get_card(Game.Draw)
		#发牌
		$"手牌".start(cards)

