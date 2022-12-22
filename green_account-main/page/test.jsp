<%@ page language="java"%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*"%>
<%@ include file = "connectsql.jsp" %> 
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,java.text.*"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" ontent="text/html; charset=gb2312" />
<title>表单元素[select下拉列表]制作二级联动菜单</title>
<script language="javascript">
//下面函数是演示二，联动菜单的处理代码
function makeshi(x){
var form2=document.diqu.one.options.length;//这句解释同上
var diqul=new Array(form2)//新建一个数组，项数为第一个下拉列表的项数
for(i=0;i<form2;i++)//循环第一个下拉列表的项数那么多次
diqul[i]=new Array();//子循环
//下面是给每个循环赋值
var shi=document.diqu.shi;//方便引用
diqul[0][0]=new Option("绵阳","绵阳");
diqul[0][1]=new Option("成都","成都");
diqul[0][2]=new Option("广元","广元");
diqul[1][0]=new Option("盐城","盐城");
diqul[1][1]=new Option("苏州","苏州");
diqul[1][2]=new Option("常州","常州");
diqul[2][0]=new Option("南宁","南宁");
diqul[2][1]=new Option("柳州","柳州");
diqul[2][2]=new Option("北海","北海");
diqul[3][0]=new Option("杭州","杭州");
diqul[3][1]=new Option("温州","温州");
diqul[3][2]=new Option("义乌","义乌");
for(m=shi.options.length-1;m>0;m--)
shi.options[m]=null;//将该项设置为空,也就等于清除了
for(j=0;j<diqul[x].length;j++){//这个循环是填充下拉列表
shi.options[j]=new Option(diqul[x][j].text,diqul[x][j].value)
//注意上面这据,列表的当前项等于 新项(数组对象的x,j项的文本为文本，)
}
shi.options[0].selected=true;//设置被选中的初始值
}
</script>
</head>