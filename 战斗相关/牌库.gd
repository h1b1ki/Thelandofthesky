extends Control
# card相当于预先将我拥有的牌放一起  就是牌库
var cards=[]

func _ready():
	cards=Game.cards
#	for x in Game.cards:
#		var copy=x.duplicate()
#		copy.rect_pivot_offset=Vector2(-150,-210)
#		cards.append(copy)

	

# 从cards中随机得到手牌   这是节点的整合
func get_card(number)->Array:
	shuffle_card()
	#牌库是否够发牌
	if number<cards.size():
		var b:Array
		for x in number:
			b.append(cards[0])
			cards.pop_front()
		return b
	#如果不够发牌，弃牌获得所有牌再洗牌
	else:
		var b:Array
		var a=number-cards.size()
		for x in cards.size():
			b.append(cards[0])
			cards.pop_front()
		cards=$"../弃牌堆".Discard.duplicate()
		$"../弃牌堆".Discard.clear()
		shuffle_card()
		for x in a:
			b.append(cards[0])
			cards.pop_front()
		return b
	#洗牌功能
func shuffle_card():
	for i in cards.size():
		var rand1=Tool.integers(0,cards.size()-1)
		var rand2=Tool.integers(0,cards.size()-1)
		var middle=cards[rand1]
		cards[rand1]=cards[rand2]
		cards[rand2]=middle
	pass

