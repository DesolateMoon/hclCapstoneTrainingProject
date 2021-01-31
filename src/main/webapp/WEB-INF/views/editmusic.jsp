<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.music.entity.Music"%>
<%@ page import="com.music.entity.User"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
	integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js"
	integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj"
	crossorigin="anonymous"></script>

<title>Products</title>
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
	
	<div class="card text-left">
		<div style="margin: auto;">
			<h1>All Products</h1>
			<h3>Checkout all the awesome products available now!</h3>
			
			Search: <input type="text" id="myInput" onkeyup="myFunction()" placeholder="Product name..." title="Type in a name">
			
			<table class="table table-striped" border='2' id="myTable">
				<tr class="table table-primary" style="text-align: center">
					<th>Photo Thumb</th>	
					<th>Product Name</th>	
					<th>Category</th>	
					<th>Condition</th>	
					<th>Price</th>	
					<th> </th>
				</tr>
				
				<%
				ArrayList<Music> musics = (ArrayList<Music>) session.getAttribute("musics");
				for (Music m : musics) {
				%>
					<tr style="text-align: center">
						<td> <img style="width: 75px; height: 75px" src="<%=m.getUrl()%>" alt="song image" /> </td>
						<td><%=m.getProductname()%></td>
						<td><%=m.getCategory()%></td>
						<td><%=m.getQuality()%></td>
						<td><%=m.getPrice()%></td>
						<td>
							<a href="/music/<%=m.getProductname()%>">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
	  								<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
	  								<path d="M8.93 6.588l-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533L8.93 6.588zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
								</svg>
							</a>
						</td>
					</tr>
				<%}%>
			</table>
			
		</div>
	</div>
	
	<script>
		function myFunction() {
			var input, filter, table, tr, td, i, txtValue;
			input = document.getElementById("myInput");
			filter = input.value.toUpperCase();
			table = document.getElementById("myTable");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[1];
				if (td) {
					txtValue = td.textContent || td.innerText;
					if (txtValue.toUpperCase().indexOf(filter) > -1) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
	</script>
</body>
</html>