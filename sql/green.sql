DROP database IF EXISTS green;
create database green;
use green;

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
    vPoint int #會員點數
);

#交易紀錄
DROP table IF EXISTS trade;
create table trade(
	tID int PRIMARY KEY, #交易編號
    tAccount varchar(20), #會員帳號
    tDate date , #交易日期
	tShop varchar(20), #店家類別
	tGoods varchar(60), #品名
    tType varchar(2), #類別
    tDetail varchar(10), #類別細項
    tShape varchar(2), #消費型態
    tMoney int, #金額
	tUnit int, #單位
	tCO2 int, #碳足跡
    FOREIGN KEY(tAccount) REFERENCES vip(vAccount)
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

#點數商店交易資料表
DROP table IF EXISTS tgoods;
create table tgoods(
	tgAccount VARCHAR(20) PRIMARY KEY, #會員編號
	tgID int, #產品編號
    tgDate date,#日期
    FOREIGN KEY(tgAccount) REFERENCES vip(vAccount),
    FOREIGN KEY(tgID) REFERENCES goods(gID)
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
