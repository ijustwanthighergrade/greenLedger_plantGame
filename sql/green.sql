DROP database IF EXISTS green;
create database green;
use green;

#管理員資料表
DROP table IF EXISTS users;
create table users(
	uAccount varchar(20) PRIMARY KEY, #帳號
	uPassword varchar(20) #密碼
);

insert into users value('user','1234');

#會員基本資料表
DROP table IF EXISTS vip;
create table vip(
	vAccount varchar(20) PRIMARY KEY, #會員帳號
	vPassword varchar(20), #會員密碼
    vName varchar(20), #會員姓名
    vGender varchar(1), #會員性別
    vBirth date , #會員生日
    vMail varchar(60), #會員電子信箱
    vPhone varchar(10), #會員電話
	vAddress varchar(60), #會員地址
    vPoint int, #會員點數
	vCO2 int #會員總碳排
);
-- insert into vip value('user','1234',"ddd1","1","2222-02-22","1","1","1","1","-5");
-- UPDATE `vip` SET `vPoint`=1234 WHERE `vAccount` = "ddd";
-- UPDATE `vip` SET `vCO2`=3 WHERE `vAccount` = "ddd";

DROP event IF EXISTS CO_date;
Create event CO_date
on schedule every 1 day starts DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 1 HOUR) on completion preserve do
UPDATE vip SET vCO2=20;


#類別細項資料庫
DROP table IF EXISTS category;
create table category(
    cType varchar(2), #類別
    cDetail varchar(10) PRIMARY KEY ,#類別細項
    ctranslate varchar(10)  #計算
);

insert into category value('食','素食','1.5');#份
insert into category value('食','非素食','2.4');#份
insert into category value('衣','衣','16');#件
insert into category value('住','月水電費','189');#月
insert into category value('住','月瓦斯費','189');#月
insert into category value('行','加油公升數','4.62825');#公升
insert into category value('行','自駕油費','0.11');#公里
insert into category value('行','捷運','0.04');#公里
insert into category value('行','公車','0.04');#公里
insert into category value('行','鐵路','0.032');#公里
insert into category value('行','長程飛機','1980');#>4小時/次數
insert into category value('行','短程飛機','495');#<4小時/次數
insert into category value('其他','具有綠色標章','1');
insert into category value('其他','非綠色標章','1');

#店家類別資料庫
DROP table IF EXISTS store;
create table store(
    sShop varchar(10)  PRIMARY KEY #店家類別
);

insert into store value('獨立商店');
insert into store value('連鎖商店');
insert into store value('便利商店負碳商品專區');
insert into store value('便利商店一般');
insert into store value('綠色商店');
insert into store value('其他');

#消費型態資料庫
DROP table IF EXISTS pattern;
create table pattern(
    pShape varchar(2) PRIMARY KEY ,#消費型態
	ptranslate varchar(10)  #計算
);

insert into pattern value('網路','0.6');#一般實體到店消費*0.6
insert into pattern value('自購','');

#交易紀錄
DROP table IF EXISTS trade;
create table trade(
	tID int , #交易編號
    tAccount varchar(20), #會員帳號
    tDate date , #交易日期
	tShop varchar(10), #店家類別
	tGoods varchar(60), #品名
    tDetail varchar(10), #類別細項
    tShape varchar(2), #消費型態
    tMoney int, #金額
	tUnit int, #單位
	tCO2 int, #碳足跡
    FOREIGN KEY(tAccount) REFERENCES vip(vAccount),
	FOREIGN KEY(tDetail) REFERENCES category(cDetail),
	FOREIGN KEY(tShop) REFERENCES store(sShop),
    FOREIGN KEY(tShape) REFERENCES pattern(pShape),
    PRIMARY KEY(tID,tAccount)
);

#探權轉移表
DROP table IF EXISTS carbon;
create table carbon(
	cID int PRIMARY KEY, #交易編號
    cGift varchar(20), #贈與者會員編號
	cAccount varchar(20), #會員編號
    cDate date, #日期
    cCO2 int, #轉贈數量
	FOREIGN KEY(cAccount) REFERENCES vip(vAccount),
    FOREIGN KEY(cGift) REFERENCES vip(vAccount)
);

#道具基本資料表
DROP table IF EXISTS item;
create table item(
	iID int PRIMARY KEY, #道具ID
	iName varchar(5), #道具名稱
    iNote text #道具說明
);

insert into item value('0','復活液','枯萎值=0');
insert into item value('1','肥料','成長度+30');
insert into item value('2','澆水','成長度+10');

#道具背包資料表
DROP table IF EXISTS back;
create table back(
	bID int PRIMARY KEY, #道具ID
    bAccount varchar(20), #道具名稱
	bImg varchar(40), #道具圖片
    bAmount int, #道具數量
    FOREIGN KEY(bID) REFERENCES item(iID),
    FOREIGN KEY(bAccount) REFERENCES vip(vAccount)
);

#題庫資料表
DROP table IF EXISTS exam;
create table exam(
	eID int PRIMARY KEY, #題目編號
	eTopic text, #題目
	eYes  text, #正確
    eWrongA text, #選項A
    eWrongB text, #選項B
    eWrongC text  #選項C
);

insert into exam value('1','美國政府於幾年成立「環境保護局」？','1970年','1895年','1760年','1950年');
insert into exam value('2','下列哪個國家有簽署《京都議定書》？','印度','美國','南蘇丹','加拿大');
insert into exam value('3','下列哪類肉品碳排放普遍最高？','牛肉','豬肉','雞肉','魚肉');
insert into exam value('4','碳盤查包括的範疇為？','以上皆是','企業／組織直接排放的溫室氣體','能源的間接排放源','其他間接排放源，由組織活動產生的溫室氣體排放');
insert into exam value('5','下列何者不屬於再生能源？','天然氣','太陽能','風力','生物燃氣');
insert into exam value('6','下列何者屬於再生能源？','水能','核燃料','煤炭','石油');
insert into exam value('7','下列何者不屬於不可再生能源？','生物燃氣','礦產','天然氣','煤炭');
insert into exam value('8','下列何者屬於不可再生能源？','鈾礦','地熱能','波浪能','風力');
insert into exam value('9','風力發電的風機哪部分可以回收？','以上皆可','鋼鐵','葉片的玻璃纖維','鋁');
insert into exam value('10','行政院環保署於民國幾年起推動垃圾強制分類？','94年','86年','90年','79年');
insert into exam value('11','下列何者可被當作「廢塑膠袋回收」？','拋棄式輕便雨衣','含油脂的透明塑膠袋','食品分裝袋','抗靜電袋');
insert into exam value('12','下列何者不可被當作「廢塑膠袋回收」？','以上皆不可','食品分裝袋','零食、泡麵包裝','清潔劑補充包');
insert into exam value('13','下列何者屬於養豬廚餘？','內臟','生菜葉','果皮','落葉');
insert into exam value('14','下列何者不屬於養豬廚餘？','果皮','麵食','過期食品','肉類');
insert into exam value('15','下列何者屬於堆肥廚餘？','生菜葉','一般家庭剩菜剩飯','魚','蝦');
insert into exam value('16','下列何者不屬於堆肥廚餘？','過期食品','落葉','果皮','生菜葉');
insert into exam value('17','廢保麗龍再生後可以製成下列哪種產品？','以上皆可','筆筒','花盆','錄影帶匣');
insert into exam value('18','下列何者是廢PET（一種廢塑膠容器材質）的再生品用途？','拉鍊','垃圾桶','腳踏車踏墊','人造皮革');
insert into exam value('19','下列何者是廢PVC（一種廢塑膠容器材質）的再生品用途？','電線覆皮','即可拍相機外殼','不織布','毛毯');
insert into exam value('20','下列何者是廢PP/PE（一種廢塑膠容器材質）的再生品用途？','腳踏車踏墊','聚酯布料','衣架','假髮');
insert into exam value('21','下列何者不屬於巨大廢棄物？','洗衣籃','沙發','桌椅','腳踏車');
insert into exam value('22','世界地球日是哪一天？','4月22日','9月28日','1月22日','11月28日');
insert into exam value('23','下列何者為溫室氣體？','水蒸氣','氮','氬','氧');
insert into exam value('24','下列何者非溫室氣體？','氮','臭氧','甲烷','二氧化碳');
insert into exam value('25','下列何者為最主要的溫室氣體？','水蒸氣','二氧化碳','臭氧','一氧化二氮');
insert into exam value('26','下列何者是聯合國為了避免工業產品中的氟氯碳化物對地球臭氧層繼續造成惡化及損害，承續1985年保護臭氧層維也納公約的大原則，於1987年9月16日簽署的環境保護議定書？','蒙特婁議定書','京都議定書','哥本哈根協定','巴黎協定');
insert into exam value('27','下列何者不是決定污染程度的三個要素？','公共安全','化學性質','濃度','持續時間');
insert into exam value('28','下列何者不是臭氧污染主要可以導致的疾病？','高血壓','呼吸系統疾病','心血管疾病','胸痛');
insert into exam value('29','下列何者不是噪音污染會對人類帶來的影響？','咽炎','睡眠障礙','壓力','耳聾');
insert into exam value('30','雨水酸鹼值達到幾以下被定義為酸雨？','5.6','7.0','6.5','8.2');
insert into exam value('31','以台灣空氣品質指數分級而言，當對敏感族群會有輕微症狀惡化的現象，如臭氧濃度在此範圍，眼鼻會略有刺激感會被分為哪一級別？','不良（101 – 199）','良好（0 – 50 ）','普通（51 – 100）','非常不良（200 – 299）');
insert into exam value('32','以台灣空氣品質指數分級而言，當對敏感族群健康無立即影響時會被分為哪一級？','普通（51 – 100）','良好（0 – 50 ）','不良（101 – 199）','非常不良（200 – 299）');
insert into exam value('33','以台灣空氣品質指數分級而言，對敏感族群會有明顯惡化的現象，降低其運動能力；一般大眾則視身體狀況，可能產生各種不同的症狀會被分為哪一級？','非常不良（200 – 299）','良好（0 – 50 ）','普通（51 – 100）','不良（101 – 199）');
insert into exam value('34','下列何者無法達到節能減碳的效果？','吃國外進口食物','吃當季食物','食物放涼再冷藏','自備環保杯');
insert into exam value('35','下列何者無法達到節能減碳的效果？','多買衣服淘汰過季的單品','洗衣前先浸泡，使污垢釋出','戶外晾曬代替烘乾','避免使用一次性餐具');
insert into exam value('36','下列何者能達到節能減碳的效果？','隨手關燈','使用紙本帳單以免忘記繳費','多泡澡代替淋浴有助於放鬆心情','買環保購物袋卻只用一次');
insert into exam value('37','環保署發佈的「節能減碳無悔十大措施」不包括下列哪個？','每週2天不開車','節能省水看標章','多吃蔬食少吃肉','鐵馬步行兼保健');
insert into exam value('38','下列何者是國際臭氧層保護日？','9月16日','4月22日','6月13日','3月18日');
insert into exam value('39','世界環境日是聯合國鼓勵全球居民提高環保意識和採取環保行動的主要力量，請問每年的哪一天？','6月5日','6月15日','4月22日','7月3日');
insert into exam value('40','下列何者不可回收？','數字鍵盤','乾電池','鉛蓄電池','直管日光燈');
insert into exam value('41','下列何者不可回收？','實心胎','輪胎外胎','乾電池','腳踏車');
insert into exam value('42','下列何者是因為全球暖化使得海水溫度上升所帶來的影響？','珊瑚白化','下酸雨頻率變高 ','臭氧層稀薄','空氣污染加重');
insert into exam value('43','下列何者屬於資源垃圾？','以上皆是','玻璃瓶','廢紙容器','鐵罐');
insert into exam value('44','水循環的能量主要來自下列何者？','太陽','星星','月亮','風力');
insert into exam value('45','「氣候變化綱要公約」規定下列哪種氣體的排放？','二氧化碳','氧氣','甲烷','氫氣');
insert into exam value('46','下列何者為節能標章的使用期限？','2年','6個月','1年','3年');
insert into exam value('47','下列何者不是垃圾分類的優點？','增加垃圾處理量','減少垃圾處理成本','延長焚化爐壽命','減少環境污染');
insert into exam value('48','下列哪個可能是海洋污染的來源？','以上皆是','空氣污染','船隻漏油','來自陸地的塑膠袋');
insert into exam value('49','下列何者無法達成節能減碳效果？','騎機車代替腳踏車','挑選天然材質製作的衣服','使用省電燈泡','購買再生紙');
insert into exam value('50','下列何者不是空氣污染帶來的影響？','增加生物多樣性','降低植物光合作用','植物生長緩慢','降低生物繁殖能力');

#會員簽到資料表
DROP table IF EXISTS sign;
create table sign(
	sAccount varchar(20) PRIMARY KEY, #會員編號
	sMon int, #星期一
	sTue int, #星期二
    sWed int, #星期三
    sThu int, #星期四
    sFri int, #星期五
    sSat int, #星期六
    sSun int, #星期天
    FOREIGN KEY(sAccount) REFERENCES vip(vAccount)
);

#圖鑑資料表
DROP table IF EXISTS photo;
create table photo(
	pID int PRIMARY KEY, #花卉編號
	pName VARCHAR(10), #花卉名稱
	pImg  VARCHAR(40) #花卉圖片
);

insert into photo value('1','001','plant(1).png');
insert into photo value('2','002','plant(2).png');
insert into photo value('3','003','plant(3).png');
insert into photo value('4','004','plant(4).png');
insert into photo value('5','005','plant(5).png');
insert into photo value('6','006','plant(6).png');
insert into photo value('7','007','plant(7).png');
insert into photo value('8','008','plant(8).png');
insert into photo value('9','009','plant(9).png');
insert into photo value('10','010','plant(10).png');

#會員擁有圖鑑資料表
DROP table IF EXISTS vphoto;
create table vphoto(
	vpAccount VARCHAR(20) PRIMARY KEY, #會員編號
	vpID int, #花卉編號
    FOREIGN KEY(vpAccount) REFERENCES vip(vAccount),
    FOREIGN KEY(vpID) REFERENCES photo(pID)
);

#待綻放資料表
DROP table IF EXISTS flower;
create table flower(
	fType VARCHAR(2) PRIMARY KEY, #狀態
	fImg VARCHAR(40) #圖片
);

insert into flower value('種子','seed(1).jpg');
insert into flower value('發芽','seed(2).jpg');
insert into flower value('花苞','seed(3).jpg');
insert into flower value('枯萎','seed(4).jpg');

#會員植物資料表
DROP table IF EXISTS vflower;
create table vflower(
	vfAccount VARCHAR(20) PRIMARY KEY, #會員編號
	vfID int, #花卉編號
    vfType varchar(2), #狀態
	vfGrow int, #植物成長值
	vfDead  int, #植物枯萎值
	FOREIGN KEY(vfAccount) REFERENCES vip(vAccount),
    FOREIGN KEY(vfID) REFERENCES photo(pID),
    FOREIGN KEY(vfType) REFERENCES flower(fType)
);

#點數商店資料表
DROP table IF EXISTS goods;
create table goods(
	gID int PRIMARY KEY, #產品編號
	gName varchar(40), #產品名稱
    gPhoto varchar(40), #產品圖片
    gPoint int, #產品點數
    gStock int #產品庫存
);

insert into goods value('0','手續費','','1','0');
insert into goods value('1','超實用筆記本(學習腳蹤)','','20','1');
insert into goods value('2','一包種子','','35','1');
insert into goods value('3','一副口罩','','50','1');
insert into goods value('4','隨機購物袋','','100','1');
insert into goods value('5','桌布圖鑑','','150','1');
insert into goods value('6','隨機二手書','','200','1');
insert into goods value('7','一包蒲公英衛生紙','','500','1');
insert into goods value('8','環保餐具','','1000','1');
insert into goods value('9','限量隨機馬克杯','','2000','1');

#點數商店交易資料表
DROP table IF EXISTS tgoods;
create table tgoods(
    tgoodsid int,
	tgAccount VARCHAR(20), #會員編號
	tgID int, #產品編號
    tgDate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,#日期
    FOREIGN KEY(tgAccount) REFERENCES vip(vAccount),
    FOREIGN KEY(tgID) REFERENCES goods(gID),
    PRIMARY KEY(tgAccount,tgoodsid)
);

#活動基本表
DROP table IF EXISTS activity;
create table activity(
	aID int PRIMARY KEY, #活動ID
	aName varchar(20), #活動名稱
	aPoint int #任務點數
);

insert into activity value('1','綠色商店消費','50');
insert into activity value('2','植物新循環','50');
insert into activity value('3','環保活動','500');
insert into activity value('4','實體活動','50');
insert into activity value('5','使用環保餐具','50');
insert into activity value('6','購買綠色標章產品','50');
insert into activity value('7','昨日碳排小於20kg','50');

#點數贈與紀錄表
DROP table IF EXISTS vactivity;
create table vactivity(
	vaAccount VARCHAR(20) PRIMARY KEY, #會員編號
	vaID int, #活動ID
    vaDate date,#日期
    FOREIGN KEY(vaAccount) REFERENCES vip(vAccount),
    FOREIGN KEY(vaID) REFERENCES activity(aID)
);
