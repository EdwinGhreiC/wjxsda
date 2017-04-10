<!--#include file="conn.asp"-->
<!--#include file="checksession.asp"-->
<% subhead = " - 修改学生信息" %>
<!--#include file="_top.asp"-->
</head>

<body>
	<!--#include file="_nav.asp"-->	
	<% if session("grade")>=ADMIN_GRADE then %>
	<div class="container">
		<form class="form-horizontal" action="editstu.asp" method="post">

			<div class="nav-btn"><button type="submit" class="btn btn-primary pull-right">确定</button><a href="index.asp" class="btn btn-default pull-left">返回</a></div>

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
				<label for="stu" class="col-xs-4 control-label text-right">学生</label>
				<div class="col-xs-8">
					<select name="stu" id="stu" class="form-control">
						<option value="0">请选择</option>
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