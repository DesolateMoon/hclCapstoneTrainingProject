<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.music.entity.User"%>	
<%@ page import="com.music.entity.Music"%>
<%@ page import="java.util.Optional"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"
	integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
	integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU"
	crossorigin="anonymous"></script>

<title>Edit Product</title>
</head>
<body>
	<div id="app" class="container">
		<nav class="navbar navbar-expand-md">
			<a class="navbar-brand">Austin's Music Store</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item active"><a class="nav-link" href="/">Home</a></li>
					<li class="nav-item"><a class="nav-link" href="/music">Products</a>
					</li>
				</ul>
				<%
				User u = (User) session.getAttribute("user"); 
				if(u != null && u.getName().equals("admin")) {
				%>
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link">Welcome: <%=u.getName()%></a></li>
						<li class="nav-item"><a class="nav-link" href="/logout">Logout</a></li>
						<li class="nav-item"><a class="nav-link" href="/admin">Admin</a></li>
					</ul>
				<%
				}
				else if(u != null) {
				%>
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link">Welcome: <%=u.getName()%></a></li>
						<li class="nav-item"><a class="nav-link" href="/logout">Logout</a></li>
						<li class="nav-item"><a class="nav-link" href="/cart">Cart</a></li>
					</ul>
				<%
				} else {
				%>
					<ul class="navbar-nav ms-auto">
						<li class="nav-item"><a class="nav-link" href="/login">Login</a></li>
						<li class="nav-item"><a class="nav-link" href="/register">Register</a></li>
					</ul>
				<%
				}
				%>
			</div>
		</nav>
	</div>

	<div style="max-width: 750px; margin: auto; border: 1px solid black; padding: 10px; margin-top: 30px; height: 740px; position: relative;"
		class="card text-dark bg-light mb-3">
		<div>
			<h1 style="margin-top: 3%"card-title">Edit Product</h1>
			<h3 style="margin-top: 3%"card-title">Please fill in product information below:</h3>
			
			</br>
			
			<%Optional<Music> music = (Optional<Music>) session.getAttribute("music");%>
			<form class="form-group" method="post" action="/admin/editproduct/<%=music.get().getProductname()%>">
				<h2 style="margin-top: 3%"card-title">Product Information</h2>
				<label class="card-header">Product Name</label> 
				<input class="form-control" type="text" name="productname" required="required" value="<%=music.get().getProductname()%>">
				<label class="card-header">Category</label> 
				<input class="form-control" type="text" name="category" required="required" value="<%=music.get().getCategory()%>">
				<label class="card-header">Quality</label> 
				<input class="form-control" type="text" name="quality" required="required" value="<%=music.get().getQuality()%>">
				<label class="card-header">Price</label> 
				<input class="form-control" type="text" name="price" required="required" value="<%=music.get().getPrice()%>">
				<label class="card-header">Product Image URL</label> 
				<input class="form-control" type="text" name="url" required="required" value="<%=music.get().getUrl()%>">
				
				</br>
				
				<input class="btn btn-primary" type="submit" value="Save">
				<a href="/music" class="btn btn-danger">Cancel</a>
			</form>
		</div>
	</div>
</body>
</html>