<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<% subhead = " - 添加" %>
<!--#include file="_top.asp"-->
</head>

<body>
	<!--#include file="_nav.asp"-->	
	<% if session("grade")>=ADMIN_GRADE then %>
	<div class="container">
		<div class="headtext"><!--添加学生违纪记录--></div>
		<%
			stu_id = replace(trim(request.querystring("stuid")),"'","")
			if stu_id<>"" then
				set rs = server.createobject("adodb.recordset")
				sql = "select sname,cname from student inner join class on student.class_id=class.id where student.id=" & stu_id
				rs.open sql,conn,1,1
				if not rs.eof then
					student_name = rs("sname")
					class_name = rs("cname")
				end if
				rs.close
				set rs = nothing
			end if
		%>

		<form class="form-horizontal" action="savevent.asp?action=create" method="post">

			<div class="nav-btn"><button type="submit" class="btn btn-primary pull-right">添加</button><a href="index.asp" class="btn btn-default pull-left">返回</a></div>

			<div class="form-group">
				<label for="stu-class" class="col-xs-4 control-label text-right">班级</label>
				<div class="col-xs-8">
				<% if stu_id="" then %>
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
				<% else %>
					<span class="label label-primary"><%= class_name %></span>
				<% end if %>
				</div>				
			</div>

			<div class="form-group">
				<label for="stu" class="col-xs-4 control-label text-right">学生</label>
				<div class="col-xs-8">
				<% if stu_id="" then %>
					<select name="stu" id="stu" class="form-control">
						<option value="0">请选择</option>
					</select>
				<% else %>
					<span class="label label-primary"><%= student_name %></span>
					<input type="hidden" name="stu" value="<%=stu_id%>">
				<% end if %>	
				</div>
			</div>

			<div class="form-group">
				<label for="violation" class="col-xs-4 control-label text-right">违纪详情</label>
				<div class="col-xs-8">
					<input type="text" name="violation" class="form-control">					
				</div>
			</div>

			<div class="form-group">
				<label for="punish" class="col-xs-4 control-label text-right">处分级别</label>
				<div class="col-xs-8">
					<select name="punish" id="punish" class="form-control">
						<option value="0">请选择</option>
						<% 
							set rs3 = server.createobject("adodb.recordset")
							sql = "select id,pname from punishment order by id"
							rs3.open sql,conn,1,1
							do while not rs3.eof
								response.write "<option value=""" & rs3("id") & """>" & rs3("pname") & "</option>"
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
					<input type="date" name="ptime" id="ptime" placeholder="YYYY-MM-DD" class="form-control">					
				</div>
			</div>

			<div class="form-group">
				<label for="current_punish" class="col-xs-4 control-label text-right">当前处分</label>
				<div class="col-xs-8">
					<select name="current_punish" id="current_punish" class="form-control">
						<option value="0">请选择</option>
						
						<% if stu_id="" then %>

						<% 
							set rs4 = server.createobject("adodb.recordset")
							sql = "select id,pname from punishment order by id"
							rs4.open sql,conn,1,1
							do while not rs4.eof
								response.write "<option value=""" & rs4("id") & """>" & rs4("pname") & "</option>"
								rs4.movenext
							loop
							rs4.close
							set rs4 = nothing
						%>

						<% else %>

						<% 
							set rscp = server.createobject("adodb.recordset")    '从学生表获取当前处分
							sql = "select punishment.id from student inner join punishment on student.punishment_id=punishment.id where student.id=" & stu_id
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

						<% end if %>
					</select>					
				</div>
			</div>
			
		</form>
	</div>
	<script src="assets/javascript/jquery.min.js"></script>
	<script>
		function getStudents(){
			$.getJSON("getstudents.asp",{classid:$("#stu-class").val()},function(data){
				$("#stu").empty();
				$("#stu").append("<option value='0'>请选择</option>")
				$.each(data,function(index,item){
					var option = "<option value='"+item['id']+"'>"+item['sname']+"</option>";
					$("#stu").append(option);
				});
			});
		}

		$(document).ready(function(){
			getStudents();
			$("#stu-class").change(function(){
				getStudents();
			});
		});
	</script>
	<% else %>
	<div class="container">权限不足</div>
	<% end if %>
</body>
</html>