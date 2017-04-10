<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<!--#include file="_top.asp"-->
</head>
<body>
<!--#include file="_nav.asp"-->
	<div class="container">		
<%  
	if request.querystring("stuid")<>"" then
		student_id = replace(trim(request.querystring("stuid")),"'","")
		showSearchResult 1,student_id
	elseif request.form("q")<>"" then
		keyword = replace(trim(request.form("q")),"'","")
		showSearchResult 2,keyword
	end if
%>

		<div class="text-center"><a href="index.asp" class="return-btn btn btn-primary">返回</a></div>
		
	</div>
</body>
</html>

<%	sub showSearchResult(qtype,queryword)    '1为id查询，2为关键字搜索
		set rs = server.createobject("adodb.recordset")
		sql = "select top 50 student.id,student.sname,student.address,student.student_phone,student.parents_phone,punishment.pname,class.cname,classteacher.tname from classteacher inner join (class inner join (punishment inner join student on punishment.id = student.punishment_id) on class.id = student.class_id) on classteacher.id = class.class_teacher_id" 
		if qtype=1 then
			sql = sql & " where student.id=" & queryword
		elseif qtype=2 then
			sql = sql & " where sname like '%" & queryword & "%'"   '通配符为%而不是*
		end if

		rs.open sql,conn,1,1
		if not rs.eof then
		do while not rs.eof %>
		<div class="student-info">
			<div class="student-info-header">
				<div class="stu-name"><%= rs("sname") %></div>
				<div class="class-teacher"><%= rs("cname") %>(<%= rs("tname") %>)</div>
			</div>
				<div class="student-detail"><strong>当前处分：<%= rs("pname") %></strong></div>
				<div class="student-detail">家庭住址：<%= rs("address") %></div>
				<div class="student-detail">学生电话：<%= rs("student_phone") %></div>
				<div class="student-detail">家长电话：<%= rs("parents_phone") %><% if session("grade")>=ADMIN_GRADE then %><span class="edit-btn"><a href="add.asp?stuid=<%=rs("id")%>" class="btn btn-primary btn-xs">添加违纪记录</a></span><% end if %></div>
			
			<% 	set rs2 = server.createobject("adodb.recordset")
				sql2 = "select studentviolation.id,violation_detail,punishment_date,revocation_date,isrevoked,(select pname from punishment where id=studentviolation.punishment_id) as punish_name,(select pname from punishment where id=studentviolation.punishment_degrade_id) as punish_degrade_name from studentviolation where studentviolation.student_id=" & rs("id") & " order by punishment_date desc"
				rs2.open sql2,conn,1,1
				do while not rs2.eof
			%>
				<div class="violation-info">
					<div class="event-detail"><span class="text-danger">处分时间：<%= rs2("punishment_date") %></span></div>
					<div class="event-detail">处分级别：<%= rs2("punish_name") %></div>
					<div class="event-detail">违纪详情：<%= rs2("violation_detail") %><% if session("grade")>=ADMIN_GRADE then %><span class="edit-btn"><a href="edit.asp?svid=<%=rs2("id")%>" class="btn btn-primary btn-xs">编辑</a></span><% end if %></div>
					<% if rs2("revocation_date")<>"" then %><div class="event-detail">降级处分：<%= rs2("punish_degrade_name") %></div>
					<div class="event-detail">降级时间：<%= rs2("revocation_date") %></div><% end if %>
				</div>
			<%	rs2.movenext
			    loop
			    rs2.close
			    set rs2 = nothing %>
        
		</div>
		<%  rs.movenext
			loop 

			else
				response.write "找不到符合条件的记录"
			end if
			
			rs.close
		    set rs = nothing
		    closeconn 
	end sub %>
