//
//  TextCompress.swift
//  iOSComponent
//
//  Created by liyang on 16/6/5.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class TextCompressVC: BaseViewController {
    @IBOutlet weak var originalLengthLabel: UILabel!
    
    @IBOutlet weak var newLengthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let originnalData               = hanziStr.dataUsingEncoding(NSUTF8StringEncoding)
        let originNalLength             = (originnalData?.length)! / 1024
        print("originnalImageData?.length:\(originNalLength)")
        self.originalLengthLabel.text   = "\(originNalLength) K"
        let compressData                = try! originnalData?.gzippedData()
        let newLength                   = (compressData?.length)! / 1024
        self.newLengthLabel.text        = "\(newLength) K"
        
        print("compressData?.length:\(newLength)")
        
        let uncompressData              = try! compressData?.gunzippedData()
        
        let tmpStr                      = String(data: uncompressData!, encoding: NSUTF8StringEncoding)
        
        print(tmpStr)
    }
}

let hanziStr = "阿啊哀唉挨矮爱碍安岸按案暗昂袄傲奥八巴扒吧疤拔把坝爸罢霸白百柏摆败拜班般斑搬板版吧疤拔把坝爸罢霸白百柏摆败拜班般斑搬板版办半伴扮拌瓣帮绑榜膀傍棒包胞雹宝饱保堡报抱暴爆杯悲碑北贝备背倍被辈奔本笨蹦逼鼻比彼笔鄙币必毕闭毙弊碧蔽壁避臂边编鞭扁便变遍辨辩辫标表别宾滨冰兵丙柄饼并病拨波玻剥脖菠播伯驳泊博搏膊薄卜补捕不布步怖部擦猜才材财裁采彩睬踩菜参餐残蚕惭惨灿仓苍舱藏操槽草册侧厕测策层叉插查茶察岔差拆柴馋缠产铲颤昌长肠尝偿常厂场敞畅倡唱抄钞超朝潮吵炒车扯彻撤尘臣沉辰陈晨闯衬称趁撑成呈承池匙尺齿耻斥赤翅充冲诚城乘惩程秤吃驰迟持臭出初除厨锄础储楚处虫崇抽仇绸愁稠筹酬丑触畜川穿传船喘串疮窗床创吹炊垂锤春纯唇蠢聪丛凑粗促醋窜催摧脆词慈辞磁此次刺从匆葱大呆代带待怠贷袋逮戴翠村存寸错曾搭达答打蛋当挡党荡档刀叨导岛丹单担耽胆旦但诞弹淡倒蹈到悼盗道稻得德的灯登等凳低堤滴敌笛底抵地弟帝递第颠典点电店垫殿叼雕吊钓调掉爹跌叠蝶丁叮盯钉顶订定丢东冬董懂动冻栋洞都斗抖陡豆逗督毒读独堵赌杜肚度渡端短段断缎朵躲惰鹅蛾额恶饿恩儿锻堆队对吨蹲盾顿多夺而耳二发乏伐罚阀法帆番翻凡烦繁反返犯泛饭范贩方坊芳防妨房仿访纺放飞非肥匪废沸肺费分吩纷芬坟粉份奋愤粪丰风封疯峰锋蜂逢缝讽凤奉佛否夫肤伏扶服俘浮符幅福抚府斧俯辅腐父付妇负附咐复赴副傅富腹覆该改盖溉概干甘纲缸钢港杠高膏糕搞稿杆肝竿秆赶敢感冈刚岗葛隔个各给根跟更耕工告哥胳鸽割搁歌阁革格弓公功攻供宫恭躬巩共贡勾沟钩狗构购够估姑孤辜古谷股骨鼓固故顾瓜刮挂乖拐怪关观官冠馆管贯惯灌罐光广归龟规轨鬼柜贵桂跪滚棍锅国果裹过哈孩海害含寒喊汉汗旱航毫豪好号浩贺黑痕很狠恨恒横衡轰耗喝禾合何和河核荷盒哄烘红宏洪虹喉猴吼后厚候乎呼忽狐胡壶湖糊化划画话怀槐坏欢还环蝴虎互户护花华哗滑猾晃谎灰恢挥辉回悔汇会缓幻唤换患荒慌皇黄煌活火伙或货获祸惑击饥绘贿惠毁慧昏婚浑魂混吉级即极急疾集籍几己圾机肌鸡迹积基绩激及既济继寄加夹佳家嘉甲挤脊计记纪忌技际剂季间肩艰兼监煎拣俭茧捡价驾架假嫁稼奸尖坚歼健舰渐践鉴键箭江姜将减剪检简见件建剑荐贱郊娇浇骄胶椒焦蕉角狡浆僵疆讲奖桨匠降酱交皆接揭街节劫杰洁结捷绞饺脚搅缴叫轿较教阶今斤金津筋仅紧谨锦尽截竭姐解介戒届界借巾晶睛精井颈景警净径竞劲近进晋浸禁京经茎惊酒旧救就舅居拘鞠局菊竟敬境静镜纠究揪九久橘举矩句巨拒具俱剧惧据距锯聚捐卷倦绢决绝觉掘嚼军君均菌俊卡开凯慨刊堪砍看康糠扛抗炕考烤靠科棵颗壳咳可渴克刻客课肯垦恳坑空孔恐控口扣寇枯哭苦库裤酷夸垮挎跨块快宽款筐狂况旷矿框亏葵愧昆捆困扩括阔垃拉啦喇腊懒烂滥郎狼廊朗浪捞劳蜡辣来赖兰拦栏蓝篮览累冷厘梨狸离犁鹂璃黎牢老姥涝乐勒雷垒泪类励例隶栗粒俩连帘怜莲礼李里理力历厉立丽利梁粮粱两亮谅辆量辽疗联廉镰脸练炼恋链良凉临淋伶灵岭铃陵零龄领僚了料列劣烈猎裂邻林笼聋隆垄拢楼搂漏露芦令另溜刘流留榴柳六龙旅屡律虑率绿卵乱掠略炉虏鲁陆录鹿滤碌路驴落妈麻马码蚂骂吗埋买轮论罗萝锣箩骡螺络骆忙芒盲茫猫毛矛茅茂冒迈麦卖脉蛮馒瞒满慢漫美妹门闷们萌盟猛蒙孟贸帽貌么没眉梅煤霉每棉免勉面苗描秒妙庙灭梦迷谜米眯秘密蜜眠绵摩磨魔抹末沫莫漠墨默蔑民敏名明鸣命摸模膜暮拿哪内那纳乃奶耐男谋某母亩木目牧墓幕慕尼泥你逆年念娘酿鸟尿南难囊挠恼脑闹呢嫩能奴努怒女暖挪欧偶辟趴捏您宁凝牛扭纽农浓弄乓旁胖抛炮袍跑泡陪培爬怕拍牌派攀盘判叛盼碰批披劈皮疲脾匹僻片赔佩配喷盆朋棚蓬膨捧乒平评凭苹瓶萍坡泼婆偏篇骗漂飘票撇拼贫品谱七妻戚期欺漆齐其奇迫破魄剖仆扑铺葡朴普汽砌器恰洽千迁牵铅谦骑棋旗乞企岂启起气弃腔强墙抢悄敲锹乔侨桥签前钱钳潜浅遣欠歉枪禽勤青轻倾清蜻情晴顷瞧巧切茄且窃亲侵芹琴屈趋渠取去趣圈全权泉请庆穷丘秋求球区曲驱群然燃染嚷壤让饶扰绕拳犬劝券缺却雀确鹊裙日绒荣容熔融柔揉肉如惹热人仁忍刃认任扔仍乳辱入软锐瑞润若弱撒洒塞赛三伞散桑嗓丧扫删衫闪陕扇善伤商裳晌嫂色森杀沙纱傻筛晒山哨舌蛇舍设社射涉摄申赏上尚捎梢烧稍勺少绍慎升生声牲胜绳省圣盛伸身深神沈审婶肾甚渗石时识实拾蚀食史使始剩尸失师诗施狮湿十什视试饰室是柿适逝释誓驶士氏世市示式事侍势书叔殊梳疏舒输蔬熟暑收手守首寿受兽售授瘦耍衰摔甩帅拴双霜爽谁鼠属薯术束述树竖数刷斯撕死四寺似饲肆松宋水税睡顺说嗽丝司私思速宿塑酸蒜算虽随岁碎诵送颂搜艘苏俗诉肃素它塌塔踏台抬太态泰贪穗孙损笋缩所索锁她他摊滩坛谈痰毯叹炭探锻堆队对吨蹲盾顿多夺涛掏滔逃桃陶淘萄讨套汤唐堂塘膛糖倘躺烫趟惕替天添田甜填挑条跳特疼腾梯踢提题蹄体剃通同桐铜童统桶筒痛偷贴铁帖厅听亭庭停挺艇土吐兔团推腿退吞屯托头投透秃突图徒涂途屠外弯湾丸完玩顽挽晚碗拖脱驼妥娃挖蛙瓦袜歪危威微为围违唯维伟伪万汪亡王网往妄忘旺望温文纹闻蚊稳问翁窝我尾委卫未位味畏胃喂慰午伍武侮舞勿务物误悟沃卧握乌污呜屋无吴五稀溪锡熄膝习席袭洗喜雾夕西吸希析息牺悉惜吓夏厦仙先纤掀鲜闲弦戏系细隙虾瞎峡狭霞下宪陷馅羡献乡相香箱详贤咸衔嫌显险县现线限削宵消销小晓孝效校笑祥享响想向巷项象像橡泻卸屑械谢心辛欣新薪些歇协邪胁斜携鞋写泄姓幸性凶兄胸雄熊休修信兴星腥刑行形型醒杏许序叙绪续絮蓄宣悬旋羞朽秀绣袖锈须虚需徐训讯迅压呀押鸦鸭牙芽选穴学雪血寻巡旬询循岩沿炎研盐蜒颜掩眼演崖哑雅亚咽烟淹延严言扬羊阳杨洋仰养氧痒样厌宴艳验焰雁燕央殃秧耀爷也冶野业叶页夜液妖腰邀窑谣摇遥咬药要乙已以蚁倚椅义亿忆艺一衣医依仪宜姨移遗疑毅翼因阴姻音银引饮隐议亦异役译易疫益谊意影映硬佣拥庸永咏泳勇印应英樱鹰迎盈营蝇赢游友有又右幼诱于予余涌用优忧悠尤由犹邮油雨语玉育郁狱浴预域欲鱼娱渔愉愚榆与宇屿羽圆援缘源远怨院愿约月御裕遇愈誉冤元员园原晕韵杂灾栽宰载再在咱钥悦阅跃越云匀允孕运皂造燥躁则择泽责贼怎暂赞脏葬遭糟早枣澡灶宅窄债寨沾粘斩展盏崭增赠渣扎轧闸眨炸榨摘胀障招找召兆赵照罩遮占战站张章涨掌丈仗帐诊枕阵振镇震争征挣睁折哲者这浙贞针侦珍真汁芝枝知织肢脂蜘执侄筝蒸整正证郑政症之支指至志制帜治质秩致智直值职植殖止只旨址纸舟周洲粥宙昼皱骤朱株置中忠终钟肿种众重州住助注驻柱祝著筑铸抓珠诸猪蛛竹烛逐主煮追准捉桌浊啄着仔姿资爪专砖转赚庄装壮状撞走奏租足族阻组祖钻嘴滋子紫字自宗棕踪总纵最罪醉尊遵昨左作坐座做办半伴扮拌瓣帮绑榜膀傍棒包胞雹宝饱保堡报抱暴爆杯悲碑北贝备背倍被辈奔本笨蹦逼鼻比彼笔鄙币必毕闭毙弊碧蔽壁避臂边编鞭扁便变遍辨辩辫标表别宾滨冰兵丙柄饼并病拨波玻剥脖菠播伯驳泊博搏膊薄卜补捕不布步怖部擦猜才材财裁采彩睬踩菜参餐残蚕惭惨灿仓苍舱藏操槽草册侧厕测策层叉插查茶察岔差拆柴馋缠产铲颤昌长肠尝偿常厂场敞畅倡唱抄钞超朝潮吵炒车扯彻撤尘臣沉辰陈晨闯衬称趁撑成呈承池匙尺齿耻斥赤翅充冲诚城乘惩程秤吃驰迟持臭出初除厨锄础储楚处虫崇抽仇绸愁稠筹酬丑触畜川穿传船喘串疮窗床创吹炊垂锤春纯唇蠢聪丛凑粗促醋窜催摧脆词慈辞磁此次刺从匆葱大呆代带待怠贷袋逮戴翠村存寸错曾搭达答打蛋当挡党荡档刀叨导岛丹单担耽胆旦但诞弹淡倒蹈到悼盗道稻得德的灯登等凳低堤滴敌笛底抵地弟帝递第颠典点电店垫殿叼雕吊钓调掉爹跌叠蝶丁叮盯钉顶订定丢东冬董懂动冻栋洞都斗抖陡豆逗督毒读独堵赌杜肚度渡端短段断缎朵躲惰鹅蛾额恶饿恩儿锻堆队对吨蹲盾顿多夺而耳二发乏伐罚阀法帆番翻凡烦繁反返犯泛饭范贩方坊芳防妨房仿访纺放飞非肥匪废沸肺费分吩纷芬坟粉份奋愤粪丰风封疯峰锋蜂逢缝讽凤奉佛否夫肤伏扶服俘浮符幅福抚府斧俯辅腐父付妇负附咐复赴副傅富腹覆该改盖溉概干甘纲缸钢港杠高膏糕搞稿杆肝竿秆赶敢感冈刚岗葛隔个各给根跟更耕工告哥胳鸽割搁歌阁革格弓公功攻供宫恭躬巩共贡勾沟钩狗构购够估姑孤辜古谷股骨鼓固故顾瓜刮挂乖拐怪关观官冠馆管贯惯灌罐光广归龟规轨鬼柜贵桂跪滚棍锅国果裹过哈孩海害含寒喊汉汗旱航毫豪好号浩贺黑痕很狠恨恒横衡轰耗喝禾合何和河核荷盒哄烘红宏洪虹喉猴吼后厚候乎呼忽狐胡壶湖糊化划画话怀槐坏欢还环蝴虎互户护花华哗滑猾晃谎灰恢挥辉回悔汇会缓幻唤换患荒慌皇黄煌活火伙或货获祸惑击饥绘贿惠毁慧昏婚浑魂混吉级即极急疾集籍几己圾机肌鸡迹积基绩激及既济继寄加夹佳家嘉甲挤脊计记纪忌技际剂季间肩艰兼监煎拣俭茧捡价驾架假嫁稼奸尖坚歼健舰渐践鉴键箭江姜将减剪检简见件建剑荐贱郊娇浇骄胶椒焦蕉角狡浆僵疆讲奖桨匠降酱交皆接揭街节劫杰洁结捷绞饺脚搅缴叫轿较教阶今斤金津筋仅紧谨锦尽截竭姐解介戒届界借巾晶睛精井颈景警净径竞劲近进晋浸禁京经茎惊酒旧救就舅居拘鞠局菊竟敬境静镜纠究揪九久橘举矩句巨拒具俱剧惧据距锯聚捐卷倦绢决绝觉掘嚼军君均菌俊卡开凯慨刊堪砍看康糠扛抗炕考烤靠科棵颗壳咳可渴克刻客课肯垦恳坑空孔恐控口扣寇枯哭苦库裤酷夸垮挎跨块快宽款筐狂况旷矿框亏葵愧昆捆困扩括阔垃拉啦喇懒烂滥郎狼廊朗浪捞劳蜡辣来赖兰拦栏蓝篮览累冷厘梨狸离犁鹂璃黎牢老姥涝乐勒雷垒泪类励例隶栗粒俩连帘怜莲礼李里理力历厉立丽利梁粮粱两亮谅辆量辽疗联廉镰脸练炼恋链良凉临淋伶灵岭铃陵零龄领僚了料列劣烈猎裂邻林笼聋隆垄拢楼搂漏露芦令另溜刘流留榴柳六龙旅屡律虑率绿卵乱掠略炉虏鲁陆录鹿滤碌路驴落妈麻马码蚂骂吗埋买轮论罗萝锣箩骡螺络骆忙芒盲茫猫毛矛茅茂冒迈麦卖脉蛮馒瞒满慢漫美妹门闷们萌盟猛蒙孟贸帽貌么没眉梅煤霉每棉免勉面苗描秒妙庙灭梦迷谜米眯秘密蜜眠绵摩磨魔抹末沫莫漠墨默蔑民敏名明鸣命摸模膜暮拿哪内那纳乃奶耐男谋某母亩木目牧墓幕慕尼泥你逆年念娘酿鸟尿南难囊挠恼脑闹呢嫩能奴努怒女暖挪欧偶辟趴捏您宁凝牛扭纽农浓弄乓旁胖抛炮袍跑泡陪培爬怕拍牌派攀盘判叛盼碰批披劈皮疲脾匹僻片赔佩配喷盆朋棚蓬膨捧乒平评凭苹瓶萍坡泼婆偏篇骗漂飘票撇拼贫品谱七妻戚期欺漆齐其奇迫破魄剖仆扑铺葡朴普汽砌器恰洽千迁牵铅谦骑棋旗乞企岂启起气弃腔强墙抢悄敲锹乔侨桥签前钱钳潜浅遣欠歉枪禽勤青轻倾清蜻情晴顷瞧巧切茄且窃亲侵芹琴屈趋渠取去趣圈全权泉请庆穷丘秋求球区曲驱群然燃染嚷壤让饶扰绕拳犬劝券缺却雀确鹊裙日绒荣容熔融柔揉肉如惹热人仁忍刃认任扔仍乳辱入软锐瑞润若弱撒洒塞赛三伞散桑嗓丧扫删衫闪陕扇善伤商裳晌嫂色森杀沙纱傻筛晒山哨舌蛇舍设社射涉摄申赏上尚捎梢烧稍勺少绍视试饰室是柿适逝释誓驶士氏世市示式事侍势书叔殊梳疏舒输蔬熟暑收手守首寿受兽售授瘦耍衰摔甩帅拴双霜爽谁鼠属薯术束述树竖数刷斯撕死四寺似饲肆松宋水税睡顺说嗽丝司私思速宿塑酸蒜算虽随岁碎诵送颂搜艘苏俗诉肃素它塌塔踏台抬太态泰贪穗孙损笋缩所索锁她他摊滩坛谈痰毯叹炭探锻堆队对吨蹲盾顿多夺涛掏滔逃桃陶淘萄讨套汤唐堂塘膛糖倘躺烫趟惕替天添田甜填挑条跳特疼腾梯踢提题蹄体剃通同桐铜童统桶筒痛偷贴铁帖厅听亭庭停挺艇土吐兔团推腿退吞屯托头投透秃突图徒涂途屠外弯湾丸完玩顽挽晚碗拖脱驼妥娃挖蛙瓦袜歪危威微为围违唯维伟伪万汪亡王网往妄忘旺望温文纹闻蚊稳问翁窝我尾委卫未位味畏胃喂慰午伍武侮舞勿务物误悟沃卧握乌污呜屋无吴五稀溪锡熄膝习席袭洗喜雾夕西吸希析息牺悉惜吓夏厦仙先纤掀鲜闲弦戏系细隙虾瞎峡狭霞下宪陷馅羡献乡相香箱详贤咸衔嫌显险县现线限削宵消销小晓孝效校笑祥享响想向巷项象像橡泻卸屑械谢心辛欣新薪些歇协邪胁斜携鞋写泄姓幸性凶兄胸雄熊休修信兴星腥刑行形型醒杏许序叙绪续絮蓄宣悬旋羞朽秀绣袖锈须虚需徐训讯迅压呀押鸦鸭牙芽选穴学雪血寻巡旬询循岩沿炎研盐蜒颜掩眼演崖哑雅亚咽烟淹延严言扬羊阳杨洋仰养氧痒样厌宴艳验焰雁燕央殃秧耀爷也冶野业叶页夜液妖腰邀窑谣摇遥咬药要乙已以蚁倚椅义亿忆艺一衣医依仪宜姨移遗疑毅翼因阴姻音银引饮隐议亦异役译易疫益谊意影映硬佣拥庸永咏泳勇印应英樱鹰迎盈营蝇赢游友有又右幼诱于予余涌用优忧悠尤由犹邮油雨语玉育郁狱浴预域欲鱼娱渔愉愚榆与宇屿羽圆援缘源远怨院愿约月御裕遇愈誉冤元员园原晕韵杂灾栽宰载再在咱钥悦阅跃越云匀允孕运皂造燥躁则择泽责贼怎暂赞脏葬遭糟早枣澡灶宅窄债寨沾粘斩展盏崭增赠渣扎轧闸眨炸榨摘胀障招找召兆赵照罩遮占战站张章涨掌丈仗帐诊枕阵振镇震争征挣睁折哲者这浙贞针侦珍真汁芝枝知织肢脂蜘执侄筝蒸整正证郑政症之支指至志制帜治质秩致智直值职植殖止只旨址纸舟周洲粥宙昼皱骤朱株置中忠终钟肿种众重州住助注驻柱祝著筑铸抓珠诸猪蛛竹烛逐主煮嘱追准捉桌浊啄着仔姿资爪专砖转赚庄装壮状撞走奏租足族阻组祖钻嘴滋子紫字自宗棕踪总纵最罪醉尊遵昨左作坐座做"