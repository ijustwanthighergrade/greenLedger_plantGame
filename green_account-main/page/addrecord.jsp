<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@page import ="java.sql.*"%>
<%@ include file = "connectsql.jsp" %> 
<%
    String add_date=request.getParameter("add_date"); 
    String type = request.getParameter("type"); 
    String typeDetail = request.getParameter("typeDetail");
    Integer money = Integer.parseInt(request.getParameter("money"));
    String store = request.getParameter("store");
    Integer unit = Integer.parseInt(request.getParameter("unit"));
    String way = request.getParameter("way");
    String pname = request.getParameter("pname");

    if(type !=null  && !type.equals("")&&typeDetail !=null  && !typeDetail.equals("") &&
        money !=null  && !money.equals("")&&store !=null  && !store.equals("") &&
        unit !=null  && !unit.equals("")&& way !=null  && !way.equals("") &&
        pname !=null  && !pname.equals("")&&add_date !=null  && !add_date.equals("")){

            

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