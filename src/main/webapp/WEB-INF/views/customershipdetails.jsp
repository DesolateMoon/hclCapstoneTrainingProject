<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.music.entity.User"%>
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

<title>Checkout Shipping</title>
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
				if(u != null) {
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

	<div style="max-width: 750px; margin: auto; border: 1px solid black; padding: 10px; margin-top: 30px; height: 970px; position: relative;"
		class="card text-dark bg-light mb-3">
		<div>
			<h1 style="margin-top: 3%"card-title">Customer</h1>
			<h3 style="margin-top: 3%"card-title">Customer Details</h3>
			
			</br>
			<form class="form-group" method="post" action="/checkout/shipping">
				<h2 style="margin-top: 3%"card-title">Customer Shipping Details</h2>
				<label class="card-header">Name</label> 
				<input class="form-control" type="text" name="name" required="required" value="<%=u.getName()%>">
				<label class="card-header">Email</label> 
				<input class="form-control" type="text" name="email" required="required" value="<%=u.getEmail()%>">
				<label class="card-header">Phone</label> 
				<input class="form-control" type="text" name="phone" required="required" value="<%=u.getPhone()%>">
				<label class="card-header">Street Name & Apartment No.</label> 
				<input class="form-control" type="text" name="shipAddress" required="required" value="<%=u.getShipAddress()%>">
				<label class="card-header">City</label> 
				<input class="form-control" type="text" name="shipCity" required="required" value="<%=u.getShipCity()%>">
				<label class="card-header">State</label> 
				<input class="form-control" type="text" name="shipState" required="required" value="<%=u.getShipState()%>">
				<label class="card-header">Country</label> 
				<input class="form-control" type="text" name="shipCountry" required="required" value="<%=u.getShipCountry()%>">
				<label class="card-header">Zipcode</label> 
				<input class="form-control" type="text" name="shipZipcode" required="required" value="<%=u.getShipZipcode()%>">
				
				</br>
				
				<a href="/checkout/billing" class="btn btn-secondary">Back</a>
				<input class="btn btn-primary" type="submit" value="Confirm Order">
			</form>
		</div>
	</div>
</body>
</html>