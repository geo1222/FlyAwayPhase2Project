
<% 
 if(request.getSession().getAttribute("customerId") == null || 
 	request.getSession().getAttribute("flightobject") == null || 
 	request.getSession().getAttribute("fareobject") == null){
	 response.sendRedirect("index.jsp");
 }else if(request.getSession().getAttribute("customerId") != null && 
		 request.getSession().getAttribute("flightobject") != null &&
		 request.getSession().getAttribute("fareobject") != null
		 ){ 
 %>

<%@page import="com.flyaway.model.Customer"%>
<%@page import="com.flyaway.model.Airport"%>
<%@page import="com.flyaway.dao.CustomerDAO"%>
<%@page import="com.flyaway.model.Fare"%>
<%@page import="com.flyaway.model.Flight"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://fonts.googleapis.com/css?family=Lato:100,300,400,700,900"
	rel="stylesheet">
<link rel="icon" href="images/header-logo.png">

<title>Fly Away</title>

</head>
<body>

	<% 
Flight flight = (Flight)session.getAttribute("flightobject");
Fare fare = (Fare)session.getAttribute("fareobject");
String travelDate = (String)session.getAttribute("traveldate");
int passengers = (int)session.getAttribute("passengers");
String day = (String)session.getAttribute("day");
int customerId = (int)session.getAttribute("customerId");
CustomerDAO cust = new CustomerDAO();
Airport srcAirport = cust.getAirportObject(flight.getSource());
Airport destAirport = cust.getAirportObject(flight.getDestination());
double totalFare = cust.calculateFare(flight.getFlightNumber(), 
		fare.getTravelClass(), passengers);
Customer customer = cust.getCustomer(customerId);
session.setAttribute("totalfare", totalFare);
%>

	<!-- header -->
	<header class="d-flex align-items-center">
		<!-- navbar -->
		<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
			<a class="navbar-brand" href="customerdetails.jsp"><i
				class="fas fa-plane pr-2 fa-2x text-primary"></i></a>

			<div class="collapse navbar-collapse " id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a href="customerdetails.jsp"
						class="nav-link">Customer Details</a></li>
					<li class="nav-item"><a href="changepassword.jsp"
						class="nav-link">Change Password</a></li>
					<li class="nav-item"><a
						class="nav-link" href="Logout">Logout</a></li>
				</ul>

			</div>
		</nav>

		<!-- Navigation -->
	</header>
	<!--Header-->

	<h2
		class="text-center text-uppercase text-primary font-weight-bold pt-5 mt-5">Booking
		Details</h2>

	<%
        		String fail = (String)request.getAttribute("Error");
                if(fail != null){		
        	%>
	<div
		class="alert alert-danger alert-dismissible fade show text-center font-weight-bold"
		role="alert">
		<%= fail %>
		<button type="button" class="close" data-dismiss="alert"
			aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<%}%>

	<div class="container jumbotron py-2">
		<dl class="row pt-3">
			<dt class="col-sm-3">Flight Number:</dt>
			<dd class="col-sm-9"><%= flight.getFlightNumber() %></dd>

			<dt class="col-sm-3">Airline:</dt>
			<dd class="col-sm-9"><%= flight.getAirline() %></dd>

			<dt class="col-sm-3">Travel Class:</dt>
			<dd class="col-sm-9"><%= fare.getTravelClass() %></dd>

			<dt class="col-sm-3">Source:</dt>
			<dd class="col-sm-9"><%= srcAirport.getAirport() %>
				(<%= srcAirport.getAirportCode() %>) <b><%= srcAirport.getCountry() %></b>
			</dd>

			<dt class="col-sm-3">Destination:</dt>
			<dd class="col-sm-9"><%= destAirport.getAirport() %>
				(<%= destAirport.getAirportCode() %>) <b><%= destAirport.getCountry() %></b>
			</dd>

			<dt class="col-sm-3">Travel Date:</dt>
			<dd class="col-sm-9"><%= travelDate %>
				| <b>(<%= day %>)
				</b>
			</dd>

			<dt class="col-sm-3">No of Passengers:</dt>
			<dd class="col-sm-9"><%= passengers %></dd>

			<dt class="col-sm-3">Total Amount to be paid:</dt>
			<dd class="col-sm-9"><%= fare.getFare() %>
				<span>&#215;</span>
				<%= passengers %>
				<span>&#61;</span>
				<%= totalFare %>
			</dd>

			<dt class="col-sm-3">Passenger Details:</dt>
			<dd class="col-sm-9">
				<dl class="row">
					<dt class="col-sm-4">Customer Id:</dt>
					<dd class="col-sm-8"><%= customer.getCustomerId() %></dd>

					<dt class="col-sm-4">Customer Name:</dt>
					<dd class="col-sm-8"><%= customer.getFirstName() %>
						&nbsp;
						<%= customer.getLastName() %>
					</dd>

					<dt class="col-sm-4">Email Address:</dt>
					<dd class="col-sm-8"><%= customer.getEmail() %></dd>

					<dt class="col-sm-4">Phone Number:</dt>
					<dd class="col-sm-8"><%=customer.getPhone() %></dd>

				</dl>
			</dd>
		</dl>

		<form class="pb-3" action="confirmbooking" method="post">
			<input class="btn btn-primary btn-block" type="submit"
				value="Confirm Booking" />
		</form>
	</div>

	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="https://use.fontawesome.com/releases/v5.5.0/js/all.js"></script>
</body>
</html>

<% } %>