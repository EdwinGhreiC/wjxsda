<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<!--#include file="_top.asp"-->
</head>
<body>
<!--#include file="_nav.asp"-->
	<div class="container">		
		<%  action = replace(trim(request.querystring("action")),"'","")
			sv_id = replace(trim(request.querystring("svid")),"'","")
			set rs = server.createobject("adodb.recordset")
			sql = "select studentviolation.id, violation_detail, sname, cname, tname, pname, punishment_date, (select pname from punishment where id=studentviolation.punishment_degrade_id) as pname2, studentviolation.revocation_date, studentviolation.isrevoked, (select pname from punishment where id=student.punishment_id) as current_pname from classteacher inner join (class inner join (punishment inner join (student inner join studentviolation on student.id = studentviolation.student_id) on punishment.id = studentviolation.punishment_id) on class.id = student.class_id) on classteacher.id = class.class_teacher_id where studentviolation.id =" & sv_id
			rs.open sql,conn,1,1
		%>
		<% if not rs.eof then

				if action = "create" then
					action_text = "添加"
				elseif action ="update" then
					action_text = "修改"
				end if

		%>
		<div class="alert alert-success" role="alert"><%= action_text %>违纪记录成功！</div>
		<div class="violation-info">
			<div class="violation-info-header">
				<div class="stu-name"><%= rs("sname") %> -<span class="c-pun"> 当前处分：<%= rs("current_pname") %></span></div>
				<div class="class-teacher"><%= rs("cname") %>(<%= rs("tname") %>)</div>
			</div>
			<div class="event-detail">违纪详情：<%= rs("violation_detail") %></div>
			<div class="event-detail">处分级别：<%= rs("pname") %></div>
			<div class="event-detail">处分时间：<%= rs("punishment_date") %><% if session("grade")>=ADMIN_GRADE then %><span class="edit-btn"><a href="edit.asp?svid=<%=rs("id")%>" class="btn btn-primary btn-xs">编辑</a></span><% end if %></div>
			<% if rs("revocation_date")<>"" then %><div class="event-detail"><span class="text-danger">降级处分：<%= rs("pname2") %></span></div>
			<div class="event-detail"><span class="text-danger">降级时间：<%= rs("revocation_date") %></span></div><% end if %>
		</div>
		<% end if %>

		<% rs.close
		   set rs = nothing
		   closeconn %>

		<div class="text-center"><a href="index.asp" class="btn btn-primary">返回</a></div>
		
	</div>
</body>
</html>