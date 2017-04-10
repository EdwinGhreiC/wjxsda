<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->

<%
	if session("grade")>=ADMIN_GRADE then

	action = replace(trim(request.querystring("action")),"'","")

	if action="create" then     '添加学生信息

		stu_name = replace(trim(request.form("stu_name")),"'","")
		class_id = replace(trim(request.form("stu-class")),"'","")
		stu_number = replace(trim(request.form("stu_number")),"'","")
		stu_address = replace(trim(request.form("stu_address")),"'","")
		stu_phone = replace(trim(request.form("stu_phone")),"'","")
		parents_phone = replace(trim(request.form("parents_phone")),"'","")		

		if stu_name<>"" and class_id<>"" then
			sql = "insert into student(sname,class_id,snumber,address,student_phone,parents_phone) values('" & stu_name & "'," & class_id & ",'" & stu_number & "','" & stu_address & "','" & stu_phone & "','" & parents_phone & "')"
			conn.execute(sql)
			response.write "添加学生信息成功 <a href='addstu.asp'>继续添加</a> <a href='index.asp'>返回首页</a>"
		else
			response.write "信息不完整，请返回重新输入"
		end if

	elseif action="update" then

		stu_id = replace(trim(request.form("stuid")),"'","")
		stu_name = replace(trim(request.form("stu_name")),"'","")
		class_id = replace(trim(request.form("stu-class")),"'","")
		stu_number = replace(trim(request.form("stu_number")),"'","")
		stu_address = replace(trim(request.form("stu_address")),"'","")
		stu_phone = replace(trim(request.form("stu_phone")),"'","")
		parents_phone = replace(trim(request.form("parents_phone")),"'","")

		if stu_id<>"" and stu_name<>"" and class_id<>"" then
			sql = "update student set sname='" & stu_name & "',snumber='" & stu_number & "',class_id=" & class_id & ",address='" & stu_address & "',student_phone='" & stu_phone & "',parents_phone='" & parents_phone & "'"
			sql = sql & " where id=" & stu_id
			conn.execute(sql)
			response.write "更新成功 <a href='index.asp'>返回首页</a>"
		else
			response.write "更新失败"
		end if

	end if




	sub save_redirect(action,sv_id)
		set rs = server.createobject("adodb.recordset")
		if action = "create" then
			sql = "select top 1 id from studentviolation order by id desc"
		elseif action = "update" then
			sql = "select id from studentviolation where id=" & sv_id
		end if
		rs.open sql,conn,1,1
		if not rs.eof then
			if action = "create" then sv_id = rs("id")
			readyToRedirect = true
		else
			response.write "找不到记录"
		end if
		rs.close
		set rs = nothing
		if readyToRedirect then response.redirect "detail.asp?action=" & action & "&svid=" & sv_id
	end sub

	end if  '结束管理员权限判断

	closeconn
%>