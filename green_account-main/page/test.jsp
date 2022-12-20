                  <%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import ="java.sql.*"%>
<%@ include file = "connectsql.jsp" %> 
                  <%
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");              

                    String acc = session.getAttribute("mem_account").toString();   
                    Integer id = Integer.parseInt(request.getParameter("id"));
                    int c=0;
                    PreparedStatement ps ;
                    ResultSet rs ;
                    sql= "SELECT `gPoint`,`gStock` FROM `goods` WHERE (`gID`=?)";
                    ps = con.prepareStatement(sql);
                    ps.setInt(1,id);
                    rs = ps.executeQuery();
                    rs.next();
                    
                    int gstock = rs.getInt("gStock"); //商品庫存
                    int gpoint = rs.getInt("gPoint"); //商品點數
                    gstock--;

                    sql= "SELECT `vPoint` FROM `vip` WHERE (`vAccount`=?)";
                    ps = con.prepareStatement(sql);
                    ps.setString(1,acc);
                    rs = ps.executeQuery();
                    rs.next();
                    int vpoint = rs.getInt("vPoint"); //使用者點數
                    vpoint-=gpoint;                   //使用者點數 - 兌換之商品點數 => 更新使用者點數


                    String sql1 = "UPDATE `vip` SET `vPoint`=? WHERE `vAccount`=?";
                    ps = con.prepareStatement(sql1);
                    ps.setInt(1,vpoint);  
                    ps.setString(2,acc);  
                    int c_vip = ps.executeUpdate();

                    sql1 = "UPDATE `goods` SET `gStock`=? WHERE `gID`=?";
                    ps = con.prepareStatement(sql1);
                    ps.setInt(1,gstock);  
                    ps.setInt(2,id);  
                    int c_goods = ps.executeUpdate();

                    out.println(c +"<br>"+ c_vip+"<br>" +c_goods);


                    %>