<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<%
	class_id = replace(trim(request.querystring("classid")),"'","")
	set rs = server.createobject("adodb.recordset")
	sql = "select id,sname from student where class_id=" & class_id & " order by sname"
	response.charset = "utf-8"
	rs.open sql,conn,1,1
	response.write "["
	i=0
	do while not rs.eof
		if i>0 then response.write ","
		response.write "{""id"":"""
		response.write rs("id") & ""","
		response.write """sname"":"""
		response.write rs("sname") & """}"
		i=i+1
		rs.movenext
	loop
	response.write "]"
	rs.close
	set rs = nothing
	closeconn
%>