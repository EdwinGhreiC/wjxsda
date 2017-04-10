<%@Language=VBScript codepage=65001 %>
<!--#include file="_top.asp"-->
<style type="text/css">
	.login {
		background-color: #fff;
		margin: 50px auto 50px auto;
		max-width: 400px;
		padding: 40px;
		border: 1px solid #ddd;
		/*box-shadow: 1px 1px 2px #eee;*/
	}

	.btn {
		margin-top: 20px;
	}

@media(max-width: 768px) {
	body {
		background-color: #fff;
	}

	.login {
		margin-top: 0;
		border-color: #fff;
	}

	.navbar {
		margin-bottom: 0;
	}
}	
</style>
</head>
<body>
<!--#include file="_nav.asp"-->	
<div class="login">
	<div class="form-group">
		<h3>温州华侨职专学生违纪档案</h3>	
	</div>
	
	<form action="checklogin.asp" method="post">
		<div class="form-group">
			<input type="text" class="form-control" placeholder="请输入用户名" name="teacher_name">
		</div>

		<div class="form-group">
			<input type="password" class="form-control" placeholder="请输入密码" name="teacher_pwd">
		</div>

		<button class="btn btn-primary btn-lg btn-block" type="submit"><span class="glyphicon glyphicon-ok-sign"></span> 登 录</button>
	</form>
</div>
</body>
</html>