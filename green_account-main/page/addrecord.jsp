<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import ="java.sql.*"%>
<%@ include file = "connectsql.jsp" %> 
<%
    String acc = session.getAttribute("mem_account").toString();   

    String add_date=request.getParameter("add_date"); 
    String type = request.getParameter("type"); 
    String typeDetail = request.getParameter("typeDetail");
    Integer money = Integer.parseInt(request.getParameter("money"));
    String store = request.getParameter("store");
    Integer unit = Integer.parseInt(request.getParameter("unit"));
    String way = request.getParameter("way");
    String pname = request.getParameter("pname");

    SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" ); 
    java.util.Date d = sdf.parse(add_date); 

    java.util.Date date = new java.util.Date();
    java.sql.Date now1 = new java.sql.Date(date.getTime()); 
    boolean c = d.before(now1);
    
    if(!c){
        %>
            <script type="text/javascript">
                alert("請勿超過今日日期");
                history.back();
            </script>                 
        <%
    }
    else{
    if(type !=null  && !type.equals("")&&typeDetail !=null  && !typeDetail.equals("") &&
        money !=null  && !money.equals("")&&store !=null  && !store.equals("") &&
        unit !=null  && !unit.equals("")&& way !=null  && !way.equals("") &&
        pname !=null  && !pname.equals("")&&add_date !=null  && !add_date.equals("")){
        
        sql= "SELECT COUNT(*) FROM `trade` WHERE (`tAccount`=?)";
        PreparedStatement ps= con.prepareStatement(sql);
        ps.setString(1, acc);
        ResultSet rs = ps.executeQuery();
        rs.next();
        int count_id = rs.getInt(1);
        out.println(count_id);
        count_id++;

        sql = "INSERT INTO `trade` VALUES ( '"+ count_id + "','"+ acc + "', '"+ add_date + "', '"+ store + "', '"+ pname + "', '"+ typeDetail + "', '"+ way + "', '"+ money + "','"+unit+"', '"+ count_id +"')";
        int y1 = con.createStatement().executeUpdate(sql);

        //要扣掉碳排



        if ( y1>0 ){
            con.close();
            response.sendRedirect("account.jsp");  
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

    }





%>