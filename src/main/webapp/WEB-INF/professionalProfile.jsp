<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome Page</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
<style>
.navbar-right {
	margin-top:15px;
	margin-right: 100px;
	color:white;
}
.logoutbtn {
    color: #ebacac;
}
div.disc {
	background-color: lightgrey;
	width: 300px;
	height: 50px;
	border: 1px solid green;
	margin-bottom: 40px;
}

fieldset {
	width: 10px;
}

div.myConnection {
	width: 300px;
	height: 100px;
	overflow-y: scroll;
	background-color: lightgrey;
	border: 1px solid green;
}

.two-column {
	width: 48%;
	margin-top: 100px;
	margin-right: 20px;
}

.row {
	margin-right: 0px;
	margin-left: 0px;
}

.post-message {
	background-color: white;
}




body {
	background-color: #f5f5f5;
}

.form-control {
	width: 100%;
}

.message-btn {
	background-color: white;
	border: 1px solid gray;
	border-radius: 10px;
	margin-top: 10px;
	margin-bottom: 10px;
}

.well {
    min-height: 20px;
    padding: 19px 19px 0px 19px;
    margin-bottom: 20px;
    background-color: #f5f5f5;
    border: 1px solid #e3e3e3;
    border-radius: 4px;
    -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    box-shadow: inset 0 1px 1px rgba(0,0,0,.05);
    background-color: white;
}


.navbar-collapse {
	
	width: 1140px;
	margin: 0 auto;
}

.navbar-inverse{
	background: #283e4a;
}

.detailBox {
   	margin-bottom: 20px;
    border:1px solid #bbb;
    background-color: white;
}

.titleBox label{
  color:#444;
  margin:0;
  display:inline-block;
}


.taskDescription {
    margin-top:10px 0;
}

.commentBox {
    padding:10px;
    border-top:1px dotted #bbb;
}
.commentBox .form-group:first-child, .actionBox .form-group:first-child {
    width:80%;
}


.titleBox {
    background-color:#fdfdfd;
  }
  
 .commentBox .form-group:nth-child(2), .actionBox .form-group:nth-child(2) {
    width:18%;
}

.commentList {
    padding:0;
    list-style:none;
    max-height:200px;
    overflow:auto;
}
.commentList li {
    margin:0;
    margin-top:10px;
}
.commentList li > div {
    display:table-cell;
}
.commentText p {
    margin:0;
}
.sub-text {
    color:#aaa;
    font-family:verdana;
    font-size:11px;
}
.actionBox {
    border-top:1px dotted #bbb;
    padding:10px;
}
.background-img {
	width:100%;
}
.pv-top-card-section__information{
	text-align: center;
	font-weight: 400;
    font-size: 12px;
  
}
.entity-list-item {
	border-top: 1px #cdcfd2 solid;
	text-align: center;
	line-height:8px;
	padding: 10px;
	font-weight: 400;
    font-size: 12px;
}

.top-section{
	padding: 0px;
}

.userboard {
	background-color: white;
}
</style>
</head>
<body>
	<div class="container">
		<header role="banner" class="navbar navbar-fixed-top navbar-inverse">
		<div class="navbar-inverse">
			<nav role="navigation" class="navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="/">Home</a></li>
					<li><a href="/users">My Network</a></li>
				 <li class="dropdown">
			        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Me
			        <span class="caret"></span></a>
			        <ul class="dropdown-menu">
			          <li><a href="user/${currentUser.id}">View Profile</a></li>
			          <li><a href="/createProfile">Update Profile</a></li>
			          <li><a href="logout">Sign out</a></li>
			        </ul>
			      </li>
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

		
		<div class="row">
			<div class="col-sm-6 profile two-column"
				style="background-color: lavender;">
				
				<div class="top-section well">
					<img class="background-img" src="${pageContext.request.contextPath}/resources/img/background.jpg">
					<div class="profile-section">
						<div class="pv-top-card-section__information">
							<h3><c:out value="${currentUser.name}"></c:out></h3>
							<p class="section-info-parag"><c:out value="${userProfile.headline}"></c:out></p>
							<p class="section-info-parag"><c:out value="${userProfile.education}"></c:out></p>
						</div>
						<div class="entity-list-item">
							<p>${currentUser.getFriends().size() + currentUser.getUserFriends().size()}</p>
							<p>Connections</p>
							<p>Grow your network</p>
						</div>
					</div>
				</div>
			</div> 

			<div class="col-sm-6 two-column left-column"
				style="background-color: lavenderblush;">
				<div class="post-message well"">
					<form  style="display: inline;" action="/messages" method="post">
						<div>
							<textarea name="message" class="form-control"
								placeholder="Share an article, photo, video or idea"
								style="min-width: 100%"></textarea>
						</div>
						<div style="display: inline;">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input id="new_message"
								class="message-btn btn btn-secondary btn-sm" type="submit"
								value="Post a message">
						</div>
					</form>

					<form style="display: inline;" action="/share/image" method="post">
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <input  style="display: inline;" id="new_message"
								class="message-btn btn btn-secondary btn-sm" type="submit"
								value="Images">
					</form>
				</div>
				<div class="wall">
					<c:forEach items="${messages}" var="msg">
						<div class="detailBox">
						
							 <div class="titleBox">
						      	<label>Message Box</label>
						        <button type="button" class="close" aria-hidden="true">&times;</button>
						    </div>
							<div class="commentBox">
								<p class="taskDescription">${ msg.getMessage() }</p>
							</div>
							 
							
							<div class="actionBox">
								<div class="comment">
								 <ul class="commentList">
									<c:forEach items="${msg.getComments()}" var="cmt">
									 	<li>
											<p class="commentText">${ cmt.getComment() }</p>
											<span class="date sub-text">on March 5th, 2014</span>
										</li>
									</c:forEach>
								</ul>
								</div>
								<form class="form-inline" action="/comments/${msg.id}" method="post">
									<div class="comment-container">
										<div class="form-group">
							            	<input name="comment" class="form-control" type="text" placeholder="Your comments" />
							            </div>
										<div class="form-group">
											<input type="hidden" name="${_csrf.parameterName}"
												value="${_csrf.token}" /> 
												<button class="btn btn-default">Add</button>
										</div>
									</div>
								</form>	
							</div>				     
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>



</body>
</html>