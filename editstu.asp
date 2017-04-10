<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<% subhead = " - 修改学生个人信息" %>
<!--#include file="_top.asp"-->
</head>

<body>
	<!--#include file="_nav.asp"-->
	<% if session("grade")>=ADMIN_GRADE then %>
	<div class="container">
		<div class="headtext"><!--修改学生个人信息--></div>
		<% 	stu_id = replace(trim(request.form("stu")),"'","")
			if stu_id<>"" then %>

		<%
			set rs = server.createobject("adodb.recordset")
			sql = "select * from student where id=" & stu_id
			rs.open sql,conn,1,1
			if not rs.eof then
				stu_id = rs("id")
				stu_name = rs("sname")
				stu_number = rs("snumber")
				class_id = rs("class_id")
				stu_address = rs("address")
				stu_phone = rs("student_phone")
				parents_phone = rs("parents_phone")
			end if
			rs.close
			set rs = nothing
		%>
		<form class="form-horizontal" action="savestu.asp?action=update" method="post">
			<div class="nav-btn"><button type="submit" class="btn btn-primary pull-right">更新</button><a href="stuindex.asp" class="btn btn-default pull-left">返回</a></div>

			<div class="form-group">
				<label for="stu_name" class="col-xs-4 control-label text-right">姓名</label>
				<div class="col-xs-8">
					<input type="text" name="stu_name" class="form-control" value="<%= stu_name %>">					
				</div>
			</div>

			<div class="form-group">
				<label for="stu-class" class="col-xs-4 control-label text-right">班级</label>
				<div class="col-xs-8">
					<select name="stu-class" id="stu-class" class="form-control">
						<option value="0">请选择</option><% 
							set rs = server.createobject("adodb.recordset")
							sql = "select id,cname from class order by id"
							rs.open sql,conn,1,1
							do while not rs.eof 
						%>
						<option value="<%= rs("id") %>"<% if rs("id") = class_id then response.write " selected=""selected""" %>><%= rs("cname") %></option><%  
							
							rs.movenext
							loop
							rs.close
							set rs = nothing
						%>
					</select>
				</div>				
			</div>

			<div class="form-group">
				<label for="stu_number" class="col-xs-4 control-label text-right">学号</label>
				<div class="col-xs-8">
					<input type="text" name="stu_number" class="form-control" value="<%= stu_number %>">					
				</div>
			</div>

			<div class="form-group">
				<label for="stu_address" class="col-xs-4 control-label text-right">家庭住址</label>
				<div class="col-xs-8">
					<input type="text" name="stu_address" class="form-control" value="<%= stu_address %>">					
				</div>
			</div>

			<div class="form-group">
				<label for="stu_phone" class="col-xs-4 control-label text-right">本人手机号码</label>
				<div class="col-xs-8">
					<input type="text" name="stu_phone" class="form-control" value="<%= stu_phone %>">					
				</div>
			</div>

			<div class="form-group">
				<label for="parents_phone" class="col-xs-4 control-label text-right">家长手机号码</label>
				<div class="col-xs-8">
					<input type="text" name="parents_phone" class="form-control" value="<%= parents_phone %>">					
				</div>
			</div>

			<input type="hidden" name="stuid" value="<%= stu_id %>">
			
		</form>
		<% end if %>
	</div>
	<script src="assets/javascript/jquery.min.js"></script>
	<% else %>
	<div class="container">权限不足</div>
	<% end if %>
</body>
</html>