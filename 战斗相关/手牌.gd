extends Node2D

signal click(card)

# 时间间隔 初始位置 预留位置 发牌动画时间
var time_interval:float=0.3
var initial_position:Vector2=Vector2(90,900)
var reserved_position:float=0.2
var give_time:float=0.3
#把得到的牌PathFollow2D放进数组中方便管理
var hold_card:Array
#把得到的牌放进数组中方便管理
var my_card:Array
#state为手牌状态控制,比如选中一张在用出或取消就不能选其他牌
enum states{
	cards_zero,
	deal_cards,
	wait_choose,
	chosen
}
var state=states.cards_zero
#即将用出的卡牌
var use_card
#将PathFollow单独出来方便使用牌后重新排序

# 实现发牌，a是一个包含所有上手手牌节点的数组
func start(a:Array):
	if state==states.cards_zero:
		state=states.deal_cards
		var number = a.size()
		#每张牌间隔
		var interval=(1-reserved_position)/number
		hold_card=[]
		
		for x in number:
			var P=PathFollow2D.new()
			$"Path2D".add_child(P)
			P.unit_offset=x*interval+reserved_position
			hold_card.append(P)
			var N=Node2D.new()
			P.add_child(N)
			N.name="Node2D"
			#hold_card.append(N)
			#生成牌时缩放为0隐藏
			N.scale=Vector2(0,0)
			var created_card:Control=a[x]
			my_card.append(created_card)
			N.add_child(created_card)
			created_card.name="card"
			created_card.connect("mouse_entered",self,"mouse_entered",[created_card])
			created_card.connect("mouse_exited",self,"mouse_exited",[created_card])
			created_card.connect("button_down",self,"button_down",[created_card])
			#抽牌时的动画
			$Tween.interpolate_property(N,"global_position",initial_position,P.global_position,give_time,Tween.TRANS_LINEAR);
			$Tween.interpolate_property(N,"scale",Vector2(0.1,0.1),Vector2(1,1),give_time,Tween.TRANS_LINEAR);
			
			$Tween.start()
			yield(get_tree().create_timer(time_interval),"timeout")
		state=states.wait_choose
		
func mouse_entered(created_card):
	if state==states.wait_choose:
		var parent=created_card.get_parent()
		parent.z_index=1
		parent.scale=Vector2(1.5,1.5)
		$Tween.interpolate_property(parent,"global_position",parent.global_position,Vector2(parent.global_position.x,800),give_time,Tween.TRANS_LINEAR);
		$Tween.interpolate_property(parent,"global_rotation",parent.global_rotation,0,give_time,Tween.TRANS_LINEAR);
		$Tween.start()
	
func mouse_exited(created_card):
	if state==states.wait_choose:
		var parent=created_card.get_parent()
		parent.z_index=0
		parent.scale=Vector2(1.0,1.0)
		$Tween.interpolate_property(parent,"position",parent.position,Vector2(0,0),give_time,Tween.TRANS_LINEAR);
		$Tween.interpolate_property(parent,"rotation",parent.rotation,0,give_time,Tween.TRANS_LINEAR);
		$Tween.start()
func button_down(created_card):
	if state==states.wait_choose:
		state=states.chosen
		use_card=created_card
		created_card
		emit_signal("click",created_card)

#让选中的牌可以成功归位
func Homing():
	state=states.wait_choose
	mouse_exited(use_card)
	use_card=null

func refresh():
	if hold_card.size()!=1:
		var interval=(1-reserved_position)/hold_card.size()
		for x in hold_card.size():
			hold_card[x].unit_offset=x*interval+reserved_position
func card_refresh():
	for x in my_card:
		x.refresh()





