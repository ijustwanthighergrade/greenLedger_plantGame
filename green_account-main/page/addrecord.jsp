<%@ page language="java" %>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.sql.*"%>
<%@ include file="connectsql.jsp" %> 
<%
    String acc = session.getAttribute("mem_account").toString();   

    String add_date=request.getParameter("add_date"); 
    String type = request.getParameter("type"); 
    String typeDetail = request.getParameter("typeDetail");
    String smoney = request.getParameter("money");
    String store = request.getParameter("store");
    String sunit = request.getParameter("unit");
    String way = request.getParameter("way");
    String pname = request.getParameter("pname");

   
    
    if(type !=null  && !type.equals("")&&typeDetail !=null  && !typeDetail.equals("") &&
        smoney !=null  && !smoney.equals("")&&store !=null  && !store.equals("") &&
        sunit !=null  && !sunit.equals("")&& way !=null  && !way.equals("") &&
        pname !=null  && !pname.equals("")&& add_date !=null  && !add_date.equals("")){
        
        int money =Integer.parseInt(smoney);
        int unit =Integer.parseInt(sunit);

        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" ); 
        java.util.Date d = sdf.parse(add_date); 

        java.util.Date date = new java.util.Date();
        java.sql.Date now1 = new java.sql.Date(date.getTime()); 
        String cur =sdf.format(now1);
        boolean c = d.before(now1);
        
        
        if(unit<1){
            %>
                <script type="text/javascript">
                    alert("單位數量不可小於1");
                    history.back();
                </script>                 
            <%
        }

        if(!c){
            %>
                <script type="text/javascript">
                    alert("請勿超過今日日期");
                    history.back();
                </script>                 
            <%
        }
        else{
            sql= "SELECT COUNT(*) FROM `trade` WHERE (`tAccount`=?)";
            PreparedStatement ps= con.prepareStatement(sql);
            ps.setString(1, acc);
            int count_id =0;
            ResultSet rs = ps.executeQuery();
            rs.next();

            if(rs.getInt(1)>0){
                sql= "SELECT `tID` FROM `trade` order by `tID` desc";
                ps= con.prepareStatement(sql);
                rs = ps.executeQuery();
                rs.next();
                count_id=rs.getInt(1);
            }
            else{
                count_id=rs.getInt(1);
            }
                count_id++;
            


            //計算此紀錄碳排 
            sql= "SELECT `ctranslate` FROM `category` WHERE `cDetail`=?"; //放倍率欄位
            ps= con.prepareStatement(sql);
            ps.setString(1,typeDetail);
            rs = ps.executeQuery();
            rs.next();
            int ratio = rs.getInt(1);
            int totalcarbon = 0;
            if(typeDetail.equals("月水電費")||typeDetail.equals("月瓦斯費")){
                totalcarbon = money*ratio*unit;
            }
            else{
                totalcarbon = ratio*unit;
            }

            if(way.equals("網路")){
                totalcarbon*=0.6;
            }
            // 放進交易紀錄
            sql = "INSERT INTO `trade` VALUES ( '"+ count_id + "','"+ acc + "', '"+ add_date + "', '"+ store + "', '"+ pname + "', '"+ typeDetail + "', '"+ way + "', '"+ money + "','"+unit+"', '"+ totalcarbon +"')";
            int y1 = con.createStatement().executeUpdate(sql);

            // ~更新本日碳排~ 
            int change=0;
            int havecarbon=0;
            //1.抓使用者碳排 扣掉此紀錄碳排
            if(add_date.equals(cur)){
                sql= "SELECT `vCO2` FROM `vip` WHERE `vAccount`=?"; // 放可用碳排欄位
                ps= con.prepareStatement(sql);
                ps.setString(1,acc);
                rs = ps.executeQuery();
                rs.next();
                havecarbon = rs.getInt(1);
                //2.更新使用者碳排
                havecarbon-=totalcarbon;
                sql = "UPDATE `vip` SET `vCO2`=? WHERE `vAccount` = ?"; // 本日碳排
                ps= con.prepareStatement(sql) ;
                ps.setInt(1, havecarbon);
                ps.setString(2, acc);
                change = ps.executeUpdate();
            }

            if(change>0){
                %>
                <script type="text/javascript">
                    alert("非更新本日紀錄");
                </script>                 
            <%
            }
            int a =0;
            if(havecarbon<0){
            %>
                <script type="text/javascript">
                    alert("此紀錄碳足跡量已超標!! \n 未來您的孫子沒有家了哭哭 °(°ˊДˋ°) °");
                </script>                 
            <%
                a++;
            }
            else{
                a++;
            }

            if ( y1>0 && a>0){
                con.close();
                response.sendRedirect("account.jsp");  
            }
            else{
            %>
                <script type="text/javascript">
                    alert("沒更新成功，事情不太對勁喔");
                </script>                 
            <%

            }

        }

    }
    else{
        %>
            <script type="text/javascript">
                alert("請填寫完整資訊");
                history.back();
            </script>                 
        <%
    }

    





%>
