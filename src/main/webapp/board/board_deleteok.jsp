<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>처리 결과</title>
</head>
<body>
	<script type="text/javascript">
		alert("${board_msg}");
		location.href = "${board_url}";
	</script>
</body>
</html>
