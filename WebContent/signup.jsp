<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<form method="post" action="signup_proc.jsp">
	ID : <input type="text" name="id"><br>
	PW : <input type="password" name="pw"><br>
	NAME : <input type="text" name="name"><br>
	<input type="submit" value="로그인">
</form>

<script src="http://code.jquery.com/jquery-3.1.1.min.js">
	
</script>
<script>
	function move() {
		$.ajax({
			url : 'idcheck.jsp',
			type : 'get',
			data : {"id" : $('input[name=id]').val()},
			success : function(result) {
				$("body").append(result);
	//			console.log(result);
			}
		});
	}
</script>