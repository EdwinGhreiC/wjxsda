<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<!--#include file="_top.asp"-->
</head>
<body>
<!--#include file="_nav.asp"-->
	<div class="container">

		<% if session("grade")>=ADMIN_GRADE then %>
		<a href="add.asp" class="btn btn-primary btn-block">添加违纪记录</a><br/>
		<form action="searchresult.asp" method="post">
			<div class="form-group search-box">
				<input type="search" name="q" class="form-control" placeholder="搜索学生姓名">
			</div>			
		</form>
		最近添加
		<% end if %>	
		<%  set rs = server.createobject("adodb.recordset")
			sql = "select top 5 student.id as stuid, studentviolation.id, violation_detail, sname, cname, tname, pname, (select pname from punishment where id=studentviolation.punishment_degrade_id) as pname2, punishment_date, studentviolation.revocation_date, studentviolation.isrevoked, (select pname from punishment where id=student.punishment_id) as current_pname from classteacher inner join (class inner join (punishment inner join (student inner join studentviolation on student.id = studentviolation.student_id) on punishment.id = studentviolation.punishment_id) on class.id = student.class_id) on classteacher.id = class.class_teacher_id"
			if session("grade")<ADMIN_GRADE then sql = sql & " where class.class_teacher_id=" & session("id")
			rs.open sql,conn,1,1
		%>
		<% do while not rs.eof %>
		<div class="violation-info">
			<div class="violation-info-header">
				<div class="stu-name"><a href="searchresult.asp?stuid=<%= rs("stuid") %>"><%= rs("sname") %></a></div>
				<div class="class-teacher"><%= rs("cname") %>(<%= rs("tname") %>)</div>
			</div>
			<div class="event-detail"><span class="text-danger">处分时间：<%= rs("punishment_date") %></span></div>
			<div class="event-detail">处分级别：<%= rs("pname") %></div>
			<div class="event-detail">违纪详情：<%= rs("violation_detail") %><% if session("grade")>=ADMIN_GRADE then %><span class="edit-btn"><a href="edit.asp?svid=<%=rs("id")%>" class="btn btn-primary btn-xs">编辑</a></span><% end if %></div>
			<% if rs("revocation_date")<>"" then %><div class="event-detail">降级处分：<%= rs("pname2") %></div>
			<div class="event-detail">降级时间：<%= rs("revocation_date") %></div><% end if %>
		</div>
		<% rs.movenext
		   loop %>

		<% rs.close
		   set rs = nothing
		   closeconn %>

	</div>
</body>
</html>