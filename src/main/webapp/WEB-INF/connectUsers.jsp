<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Network</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>

<style>
.navbar-right {
	margin-top:15px;
	margin-right: 100px;
	color:white;
}
.logoutbtn {
    color: #ebacac;
}
body{
 background-color:#f5f5f5;
}
.detailBox {
	margin-bottom: 20px;
	
	margin-top: 100px;
}

.user {
	border: 1px solid #bbb;
	background-color: white;
	text-align: center;
	padding-top:10px;
}

.userboard {
	border: 1px solid #bbb;
}

.navbar .navbar-nav {
	display: inline-block;
	float: none;
	vertical-align: top;
}

.navbar-collapse {
	margin: auto;
	width: 1170px;
}

.navbar-inverse{
	background: #283e4a;
}

.nonNetwork {
	
	margin-left: 20px;
	padding: 0;
}
.no-invit {
	background-color: white;
	padding: 10px 24px 9px;
	box-shadow: 0 2px 0px 0px #C0C0C0;
}
.nonNetwork-header{
	border: 1px solid #bbb;
	padding: 10px 24px 9px;
	background-color: white;
}
.info-occupat{
	font-weight: 400;
    font-size: 12px;
    line-height: 16px;
    color: rgba(0,0,0,.6);
}
.connectbtn {
	margin-top: 10px;
	margin-bottom: 10px;
}
.userboard {
	background-color:white;
	text-align:center;
}
.logoutLblPos{
   position:fixed;
   right:200px;
   top:5px;
   margin-top:10px;
   
}
.btn{
  padding:2px;

}
</style>
<body>
	<div class="container">
		<header role="banner" class="navbar navbar-fixed-top navbar-inverse">
		<div class="navbar-inverse">

			<nav role="navigation" class="navbar-collapse">
			<ul class="nav navbar-nav">
				<li><a href="/">Home</a></li>
				<li><a href="/users">My Network</a></li>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#">Me <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="user/${currentUser.id}">View Profile</a></li>
						<li><a href="/createProfile">Update Profile</a></li>
						<li><a href="logout">Sign out</a></li>
					</ul></li>
			</ul>

			<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><security:authorize
							access="isAuthenticated()">
							<a class="logoutbtn" href="logout"><span class="glyphicon glyphicon-log-in"></span>
								Logout</a>
						</security:authorize></li>
				</ul>
			</nav>
		</div>
		</header>

		<div class="row detailBox">
			<div class="well col-xs-6 col-sm-3 userboard">
				<p>${currentUser.getFriends().size() + currentUser.getUserFriends().size()}</p>
				<p>
					<b>Your connections</b>
				</p>
				<a href="#">See all</a>
			</div>
			<div class="nonNetwork col-xs-6">
				<c:choose>
					<c:when test="${invitations.size() != 0}">

						<div class="invitations">
							<div>
								<h4>Invitation</h4>
								<p>The following people asked you to be their network.</p>
								<table border=1>
									<tr>
										<th>Name</th>
										<th>Action</th>
									</tr>

									<c:forEach var="inv" items="${invitations}">
										<tr>
											<td><a href="user/${inv.id}">${inv.getName()}</a></td>
											<td><a href="/accept/user/${inv.id}">Accept Invite</a> <a
												href="/ignore/user/${inv.id}">Ignore</a></td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</div>

					</c:when>
					<c:otherwise>
						<div class=" no-invit well">
							<p>No pending invitations</p>
						</div>

					</c:otherwise>
				</c:choose>

				<div class=" well nonNetwork-header">People you may know</div>
				<c:forEach var="user" items="${users}">
					<div class="col-xs-6 .col-sm-3 user">
						<p>
							<a style="color:black;" href="user/${user.id}"><b>${user.name}</b></a>
						</p>
						<div>
							<c:forEach var="profile" items="${profiles}">
								<c:if test="${profile.id == user.id }">
									<p class="info-occupat">${profile.getHeadline()}</p>
									<p class="info-occupat">${profile.getEducation()}</p>
								</c:if>
							</c:forEach>
						</div>
						
						<div class="btn-group">
						   <a href="connect/user/${user.id}"  class="connectbtn btn btn-primary">Connect</a>
						</div>
						
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>