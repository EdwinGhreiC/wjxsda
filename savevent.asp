<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<meta charset="UTF-8">
	<title>添加记录与更新记录</title>
</head>
<body>
<%
	if session("grade")>=ADMIN_GRADE then

	action = replace(trim(request.querystring("action")),"'","")

	if action="create" then

		stu_id = replace(trim(request.form("stu")),"'","")
		vio_detail = replace(trim(request.form("violation")),"'","")
		pun_id = replace(trim(request.form("punish")),"'","")
		pun_date = replace(trim(request.form("ptime")),"'","")
		current_pun_id = replace(trim(request.form("current_punish")),"'","")

		if stu_id<>0 and vio_detail<>"" and pun_id<>0 then
			sql = "insert into studentviolation(student_id,violation_detail,punishment_id,punishment_date) values(" & stu_id & ",'" & vio_detail & "'," & pun_id & ",'" & pun_date & "')"
			conn.execute(sql)    '更新违纪事件表
			sql = "update student set punishment_id=" & current_pun_id & " where id=" & stu_id
			conn.execute(sql)    '更新学生表的当前处分字段
			save_redirect action,0
		else
			response.write "信息不完整，请返回重新输入"
		end if

	elseif action="update" then

		stu_id = replace(trim(request.form("stu")),"'","")
		vio_detail = replace(trim(request.form("violation")),"'","")
		pun_id = replace(trim(request.form("punish")),"'","")
		pun_degrade_id = replace(trim(request.form("punish_degrade")),"'","")
		pun_date = replace(trim(request.form("ptime")),"'","")
		revoke_date = replace(trim(request.form("rtime")),"'","")
		current_pun_id = replace(trim(request.form("current_punish")),"'","")
		sv_id = replace(trim(request.form("svid")),"'","")

		if vio_detail<>"" and pun_id<>0 and pun_id<>"" and pun_date<>"" then
			sql = "update studentviolation set violation_detail='" & vio_detail & "',punishment_id=" & pun_id & ",punishment_degrade_id=" & pun_degrade_id & ",punishment_date='" & pun_date & "'"
			if revoke_date<>"" then
				sql = sql & ",revocation_date='" & revoke_date & "',isRevoked=Yes"
			end if
			sql = sql & " where id=" & sv_id
			conn.execute(sql)
			sql = "update student set punishment_id=" & current_pun_id & " where id=" & stu_id
			conn.execute(sql)    '更新学生表的当前处分字段
			save_redirect action,sv_id
		else
			response.write "更新失败, 请填好各项数据。"
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
</body>
</html>