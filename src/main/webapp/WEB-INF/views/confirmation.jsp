<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.music.entity.Music"%>
<%@ page import="com.music.entity.User"%>
<%@ page import="com.music.entity.Orders"%>
<%@ page import="java.util.*"%>
<%@ page import="java.math.BigDecimal"%>
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
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
	integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"
	integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css"
        integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Checkout Confirmation</title>
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
	
	<div class="card text-left">
		<div style="margin: auto;">
			<h1>Order</h1>
			<h3>Order Confirmation</h3>
			
			</br>
			
			<h2 style="text-align: center">Receipt</h2>
			
			<b>Shipping Address</b></br>
			<%=u.getShipAddress()%> </br>
			<%=u.getShipCity()%>, <%=u.getShipState()%> </br>
			<%=u.getShipCountry()%>, <%=u.getShipZipcode()%> </br>
			
			
			</br> </br>
			
			<b>Billing Address</b> </br>
			<%=u.getBillAddress()%> </br>
			<%=u.getBillCity()%>, <%=u.getBillState()%> </br>
			<%=u.getBillCountry()%>, <%=u.getBillZipcode()%> </br>
			
			</br>
			
			<table class="table table-striped" border='2' id="myTable">
				<tr class="table table-primary" style="text-align: center">
					<th>Product</th>	
					<th>Unit Price</th>	
					<th>Quantity</th>	
					<th>Price</th>	
				</tr>
				
				<%
				ArrayList<Orders> orders = (ArrayList<Orders>) session.getAttribute("orders");
				BigDecimal total = new BigDecimal(0);
				if(orders != null) {
					for (Orders o : orders) {
				%>
						<tr style="text-align: center">
							<td><%=o.getProductname().get().getProductname()%></td>
							<td><%=o.getProductname().get().getPrice()%></td>
							<td><%=o.getQuantity()%></td>
							<%
								String temp = o.getProductname().get().getPrice().replace("$","");
								BigDecimal sPrice = new BigDecimal(temp);
								sPrice = sPrice.multiply(new BigDecimal (o.getQuantity()));
								total = total.add(sPrice);
							%>
							<td>$<%=sPrice%></td>
							
						</tr>
				<%
					}
				}	
				%>
				
			</table>
			<h4>Grand Total: $<%=total%></h4>
			
			</br>
			</br>
			<a href="/checkout/shipping" class="btn btn-secondary">Back</a>
			<a href="/checkout/confirmation/success" class="btn btn-success">Submit Order</a>
			<a href="/cart" class="btn btn-secondary">Cancel</a>
		</div>
	</div>
	
</body>
</html>