<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<% subhead = " - 修改" %>
<!--#include file="_top.asp"-->
</head>

<body>
	<!--#include file="_nav.asp"-->
	<% if session("grade")>=ADMIN_GRADE then %>
	<div class="container">
		<div class="headtext"><!--修改学生违纪记录--></div>
		<%
			sv_id = replace(trim(request.querystring("svid")),"'","")
			set rssv = server.createobject("adodb.recordset")
			sql = "select class_id,student_id,violation_detail,studentviolation.punishment_id,studentviolation.punishment_degrade_id,punishment_date,revocation_date from studentviolation inner join student on studentviolation.student_id = student.id where studentviolation.id=" & sv_id
			rssv.open sql,conn,1,1
			if not rssv.eof then
				selected_class_id = rssv("class_id")
				selected_student_id = rssv("student_id")
				selected_violation = rssv("violation_detail")
				selected_punishment_id = rssv("punishment_id")
				selected_punishment_degrade_id = rssv("punishment_degrade_id")
				selected_punishment_date = formatDate(rssv("punishment_date"))
				if rssv("revocation_date")<>"" then selected_revocation_date = formatDate(rssv("revocation_date"))
			end if
			rssv.close
			set rssv = nothing
		%>
		<form class="form-horizontal" action="savevent.asp?action=update" method="post">

			<div class="nav-btn"><button type="submit" class="btn btn-primary pull-right">更新</button><a href="index.asp" class="btn btn-default pull-left">返回</a></div>

			<div class="form-group">
				<label for="stu-class" class="col-xs-4 control-label text-right">事件编号</label>
				<div class="col-xs-8">
					<span class="label label-default"><%= sv_id %></span>
				</div>				
			</div>

			<div class="form-group">
				<label for="stu-class" class="col-xs-4 control-label text-right">班级</label>
				<div class="col-xs-8"><% 
						set rs = server.createobject("adodb.recordset")
						sql = "select id,cname from class where id=" & selected_class_id
						rs.open sql,conn,1,1
						if not rs.eof then
					%><span class="label label-primary"><%= rs("cname") %></span><% 
						end if
						rs.close
						set rs = nothing %>
				</div>				
			</div>

			<div class="form-group">
				<label for="stu" class="col-xs-4 control-label text-right">学生</label>
				<div class="col-xs-8"><%
						set rsstu = server.createobject("adodb.recordset")
						sql = "select id,sname from student where id=" & selected_student_id
						rsstu.open sql,conn,1,1
						if not rsstu.eof then
							stu_id = rsstu("id")
					%><span class="label label-primary"><%= rsstu("sname") %></span>
					  <input type="hidden" name="stu" value="<%=stu_id%>">
					<%
					    end if
					    rsstu.close
					    set rsstu = nothing %>
				</div>
			</div>

			<div class="form-group">
				<label for="violation" class="col-xs-4 control-label text-right">违纪详情</label>
				<div class="col-xs-8">
					<input type="text" name="violation" class="form-control" value="<%= selected_violation %>">					
				</div>
			</div>

			<div class="form-group">
				<label for="punish" class="col-xs-4 control-label text-right">处分级别</label>
				<div class="col-xs-8">
					<select name="punish" id="punish" class="form-control">
						<% 
							set rs3 = server.createobject("adodb.recordset")
							sql = "select id,pname from punishment order by id"
							rs3.open sql,conn,1,1
							do while not rs3.eof %>
						<option value="<%= rs3("id") %>"<% if rs3("id") = selected_punishment_id then response.write " selected=""selected""" %>><%= rs3("pname") %></option>
						<%
								rs3.movenext
							loop
							rs3.close
							set rs3 = nothing
						%>
					</select>					
				</div>
			</div>

			<div class="form-group">
				<label for="ptime" class="col-xs-4 control-label text-right">处分时间</label>
				<div class="col-xs-8">
					<input type="date" name="ptime" id="ptime" placeholder="YYYY-MM-DD" class="form-control" value="<%= selected_punishment_date %>">					
				</div>
			</div>

			<div class="form-group">
				<label for="punish_degrade" class="col-xs-4 control-label text-right">降级处分</label>
				<div class="col-xs-8">
					<select name="punish_degrade" id="punish_degrade" class="form-control">
						<option value="0">无</option>
						<% 
							set rsdg = server.createobject("adodb.recordset")   '获取已有的降级处分id
							sql = "select id,pname from punishment order by id"
							rsdg.open sql,conn,1,1
							do while not rsdg.eof %>
						<option value="<%= rsdg("id") %>"<% if rsdg("id") = selected_punishment_degrade_id then response.write " selected=""selected""" %>><%= rsdg("pname") %></option>
						<%
								rsdg.movenext
							loop
							rsdg.close
							set rsdg = nothing
						%>
					</select>					
				</div>
			</div>

			<div class="form-group">
				<label for="rtime" class="col-xs-4 control-label text-right">降级处分时间</label>
				<div class="col-xs-8">
					<input type="date" name="rtime" id="rtime" placeholder="YYYY-MM-DD" class="form-control" value="<%=	selected_revocation_date %>">					
				</div>
			</div>

			<div class="form-group">
				<label for="current" class="col-xs-4 control-label text-right">当前处分</label>
				<div class="col-xs-8">
					<select name="current_punish" id="current_punish" class="form-control">
						<option value="0">请选择</option>
						<% 
							set rscp = server.createobject("adodb.recordset")    '从学生表获取当前处分
							sql = "select punishment.id from student inner join punishment on student.punishment_id=punishment.id where student.id=" & selected_student_id
							rscp.open sql,conn,1,1
							if not rscp.eof then selected_student_current_punish_id = rscp("id")
							rscp.close
							set rscp = nothing

							set rs4 = server.createobject("adodb.recordset")
							sql = "select id,pname from punishment order by id"
							rs4.open sql,conn,1,1
							do while not rs4.eof %>
						<option value="<%= rs4("id") %>" <% if rs4("id") = selected_student_current_punish_id then response.write " selected=""selected""" %>><%= rs4("pname") %></option><%							
							rs4.movenext
							loop
							rs4.close
							set rs4 = nothing
						%>
					</select>					
				</div>
			</div>
			
			<input type="hidden" name="svid" value="<%= sv_id %>">			
		</form>
	</div>
	<script src="assets/javascript/jquery.min.js"></script>
	<% else %>
	<div class="container">权限不足</div>
	<% end if %>

<%
    function formatDate(t_date)
        y = year(t_date)
        m = month(t_date)
        d = day(t_date)
        if len(m)<2 then m = "0" & m
        if len(d)<2 then d = "0" & d
        formatDate = y & "-" & m & "-" & d
    end function
%>
</body>
</html>