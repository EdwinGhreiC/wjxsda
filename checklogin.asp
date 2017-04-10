<!--#include file="conn.asp"-->
<!--#include file="md5.asp"-->
<%
	teacher_name = replace(trim(request.form("teacher_name")),"'","")
	teacher_pwd = replace(trim(request.form("teacher_pwd")),"'","")

	set rs = server.createobject("adodb.recordset")
	sql = "select * from classteacher where tname='" & teacher_name & "'"
	rs.open sql,conn,1,1
	if rs.eof then
		response.write "用户名不存在"
	else
		set rs2 = server.createobject("adodb.recordset")
		sql2 = "select * from classteacher where tname='" & teacher_name & "' and password='" & teacher_pwd & "'"
		rs2.open sql2,conn,1,1
		if rs2.eof then
			response.write "密码错误"
		else
			session("id") = rs2("id")
			session("teacher_name") = rs2("tname")
			session("grade") = rs2("grade")
			readyToRedirect = true
		end if 
		rs2.close
		set rs2 = nothing
	end if
	rs.close
	set rs = nothing
	closeconn
	if readyToRedirect then response.redirect "index.asp"
%>