<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<% dim action,rs,sql
   action = Trim(Request.QueryString("action"))
   sql = Trim(Request.Form("sqltext"))
   if session("grade")>=ADMIN_GRADE then
       if action = "Exec" then
              if sql<>"" then
                  conn.execute "delete from studentviolation where id=" & sql
                  response.Write(sql)
              end if
       end if
   end if

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Υ�ͼ�¼ɾ��</title>
</head>

<body>
<form name="form1" method="post" action="SqlEdit.asp?action=Exec">
  <p>
    <input name="sqltext" type="text" id="sqltext" size="80" placeholder="�����¼����">
  </p>
  <p>
    <input type="submit" name="Submit" value="�ύ">
  </p>
</form>
</body>
</html>
