<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<% subhead = " - 添加学生个人信息" %>
<!--#include file="_top.asp"-->
</head>

<body>
	<!--#include file="_nav.asp"-->	
	<% if session("grade")>=ADMIN_GRADE then %>
	<div class="container">
		<div class="headtext"><!--添加学生个人信息--></div>
		<form class="form-horizontal" action="savestu.asp?action=create" method="post">
			<div class="nav-btn"><button type="submit" class="btn btn-primary pull-right">添加</button><a href="index.asp" class="btn btn-default pull-left">返回</a></div>

			<div class="form-group">
				<label for="stu_name" class="col-xs-4 control-label text-right">姓名</label>
				<div class="col-xs-8">
					<input type="text" name="stu_name" class="form-control">					
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
						<option value="<%= rs("id") %>"><%= rs("cname") %></option><%  
							
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
					<input type="text" name="stu_number" class="form-control">					
				</div>
			</div>

			<div class="form-group">
				<label for="stu_address" class="col-xs-4 control-label text-right">家庭住址</label>
				<div class="col-xs-8">
					<input type="text" name="stu_address" class="form-control">					
				</div>
			</div>

			<div class="form-group">
				<label for="stu_phone" class="col-xs-4 control-label text-right">本人手机号码</label>
				<div class="col-xs-8">
					<input type="text" name="stu_phone" class="form-control">					
				</div>
			</div>

			<div class="form-group">
				<label for="parents_phone" class="col-xs-4 control-label text-right">家长手机号码</label>
				<div class="col-xs-8">
					<input type="text" name="parents_phone" class="form-control">					
				</div>
			</div>
			
		</form>
	</div>
	<script src="assets/javascript/jquery.min.js"></script>
	<% else %>
	<div class="container">权限不足</div>
	<% end if %>
</body>
</html>