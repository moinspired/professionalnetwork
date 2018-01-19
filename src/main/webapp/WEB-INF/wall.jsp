<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome Page</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<style>
.message-container{
	background-color: red;
	margin-bottom: 30px;
}
.comment-container {
	margin-left: 30px;
}
</style>
<body>
	<div class="header">
		<h1>Wall</h1>
		<h3>
			Hello
			<c:out value="${currentUser.name}"></c:out>
		</h3>
		<a href="/users/logout">Log off</a>
	</div>
	<div class="contianer">
		<form action="/messages" method="post">
			<div>
				<label>Post a Message</label>
			</div>
			<div>
				<textarea name="message" rows="5"></textarea>
			</div>
			<div>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csrf.token}" /> <input id="new_message" type="submit"
					value="Post a message">
			</div>
		</form>
		<div class="wall">
			<c:forEach items="${messages}" var="msg">
				<div class="message-container">
					<div class="message">
						<p>${ msg.getMessage() }</p>
					</div>
					<div class="comment">
						<c:forEach items="${msg.getComments()}" var="cmt">
							<p>${ cmt.getComment() }</p>
						</c:forEach>
					</div>
					<form action="/comments/${msg.id}" method="post">
						<div class="comment-container">
							<div>
								<label>Post a commnet</label>
							</div>
							<div>
								<textarea name="comment" rows="5"></textarea>
							</div>
							<div>
								<input type="hidden" name="${_csrf.parameterName}"	value="${_csrf.token}" />
								<input id="new_message" type="submit" value="Post a comment">
							</div>
						</div>
					</form>
				</div>
			</c:forEach>
		</div>
	</div>

</body>
</html>