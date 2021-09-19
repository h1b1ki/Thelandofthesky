extends Node
#选择的英雄数据
var choose_hero="1"
#英雄 金钱 尘埃
var dust:int
var money:int
#获胜后可以得到几张卡
var reward_number:int=3
#怪物权重
var weight:int
#拥有的卡牌
var hero_card={
	"打击":6,
	"防御":6,
	"虚弱":24
}#hero_card["AA"]=8,在字典中添加数据
#buff
var self_buff={
}
var enemy_buff={
} 
var map=1
#生成的牌组,用来全局传递
var cards=[]
var reward_cards=[]
#生成的怪物,用来全局传递
var monster=[]
#暂存buff节点
var buff=[]
#每回合抽卡数
var Draw=6

func _init():
	get_card_data()
	
#func Refresh():
#	get_card_data()

func get_card_data():
	var data=hero_card.keys()
	for key in data:
		for x in hero_card.get(key):
			create_card(key)
func create_card(name):
	#load_card是一张卡牌节点
	var load_card=load("res://卡牌/卡牌.tscn").instance();
	load_card.initialization(CardDatabase.get_data(name))
	cards.append(load_card)



func get_monster_data():
	var id
	if Game.map==1:
		id=Tool.integers(0,10)
		id=0
	creat_monster(id)
func creat_monster(id):
	var name=MonsterDatabase.get_data(id)
	var load_monster=load("res://人物/敌人/first_floor/"+name+".tscn").instance();
	monster.append(load_monster)

#func get_buff_data(name):
#	buff.clear()
#	var id
#	if Game.map==1:
#		id=Tool.integers(0,10)
#		id=0
#	creat_monster(id)
func creat_buff(name,rounds,me):
	buff.clear()
	var load_buff=load("res://buff/模板.tscn").instance();
	#ture buff自己 false buff敌人
	if me:
		#如果buff存在
		if name in self_buff:
			self_buff[name]+=rounds
		else:				
			self_buff[name]=rounds
			load_buff.initialization(BuffDatabase.get_data(name))
			buff.append(load_buff)
			doBuff.dobuff(name,me)
	else:
		if name in enemy_buff:
			enemy_buff[name]+=rounds
		else:				
			enemy_buff[name]=rounds
			load_buff.initialization(BuffDatabase.get_data(name))
			buff.append(load_buff)		
			doBuff.dobuff(name,me)

#生成奖励卡牌
func rewardcard():
	for i in reward_number:
		var load_card=load("res://卡牌/卡牌.tscn").instance();
		load_card.initialization(CardDatabase.get_data('打击'))
		reward_cards.append(load_card)
func clear():
	weight=0
	self_buff.clear()
	enemy_buff.clear()
	reward_cards.clear()
	monster.clear()
	doBuff.clear()
