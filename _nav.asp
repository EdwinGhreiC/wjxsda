	<nav class="navbar navbar-default navbar-inverse">
		<div class="container">
			<div class="sitename">学生违纪档案<%= subhead %></div>
			<% if session("id")<>"" and session("grade")>=ADMIN_GRADE then %>			
			<div class="dropdown admin-menu">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">管理菜单 <span class="caret"></span></a>
				<ul class="dropdown-menu" style="left: 28px">
					<li><a href="addstu.asp">添加学生信息</a></li>
					<li><a href="stuindex.asp">修改学生信息</a></li>
				</ul>
			</div>
			<% end if %>
			<div class="navbar-item text-right">
				<%
					response.charset = "utf-8"
					if session("id")="" then
					    response.write "<a href=""login.asp"">登录</a>"
					else
						response.write session("teacher_name") & " | " & "<a href=""logout.asp"">注销</a>"
					end if
				%>
			</div>
		</div>
	<script src="assets/javascript/jquery.min.js"></script>
	<script src="assets/javascript/bootstrap.min.js"></script>
	</nav>