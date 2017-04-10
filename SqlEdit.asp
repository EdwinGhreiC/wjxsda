<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<% dim action,rs,sql
   action = Trim(Request.QueryString("action"))
   sql = Trim(Request.Form("sqltext"))
   if action = "Exec" then
	  conn.execute sql
         response.Write(sql)
   end if

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>SQL语句直接修改</title>
</head>

<body>
<form name="form1" method="post" action="SqlEdit.asp?action=Exec">
  <p>
    <input name="sqltext" type="text" id="sqltext" size="80">
  </p>
  <p>
    <input type="submit" name="Submit" value="提交">
  </p>
</form>
</body>
</html>
