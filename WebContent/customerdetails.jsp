
<% 
 if(request.getSession().getAttribute("customerId") == null){
	 response.sendRedirect("index.jsp");
 }else if(request.getSession().getAttribute("customerId") != null){ 
 %>

<%@page import="com.flyaway.model.Airport"%>
<%@page import="com.flyaway.model.Flight"%>
<%@page import="com.flyaway.dao.CustomerDAO"%>
<%@page import="com.flyaway.model.Reservation"%>
<%@page import="java.util.List"%>
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


	<!-- header -->
	<header class="d-flex align-items-center">
		<!-- navbar -->
		<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
			<a class="navbar-brand" href="customerdetails.jsp"><i
				class="fas fa-plane pr-2 fa-2x text-primary"></i></a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive">
				<span class="navbar-toggler-icon"></span>
			</button>

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


	<section>

		<% 
	List<Reservation> reservationList = null;
	CustomerDAO cust = new CustomerDAO();
	Integer customerId = (Integer)session.getAttribute("customerId");
	if(customerId != null){
		reservationList = cust.showReservations(customerId);
	}
%>

		<%
        		String success = (String)request.getAttribute("SUCCESS");
                if(success != null){		
        	%>
		<div
			class="alert alert-success alert-dismissible fade show text-center font-weight-bold mt-5"
			role="alert">
			<%= success %>
			<i class="fas fa-check-circle ml-2 fa-2x"></i>
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<%}%>


		<%
        		String fail = (String)request.getAttribute("FAIL");
                if(fail != null){		
        %>
		<div
			class="alert alert-danger alert-dismissible fade show text-center font-weight-bold mt-5"
			role="alert">
			<%= fail %>
			<i class="fas fa-times-circle ml-2 fa-2x"></i>
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
		</div>
		<%}%>

		<div class="btn-group mt-5 pt-5" role="group"
			aria-label="Basic example">
			<a href="bookflight.jsp" class="btn btn-primary pl-3 ml-3">Book
				a new Journey</a> <a href="changepassword.jsp"
				class="btn btn-primary px-4 mx-4 ">Change Password</a>
		</div>


		<%
	
	if(reservationList.size() == 0){ %>

		<div
			class="alert alert-danger text-center text-uppercase text-primary font-weight-bold"
			role="alert">You have not done any Reservations Yet.</div>

		<%}else if(reservationList.size() != 0){ %>

		<h2 class="text-center text-uppercase text-primary font-weight-bold">All
			Booking Details</h2>
		<div class="container p-5 m-5 text-center">
			<table id="BasicExample"
				class="table table-striped table-hover table-light table-bordered">
				<thead class="thead-dark">
					<tr>
						<th class="th text-center py-3">Booking Id</th>
						<th class="th text-center py-3">Flight Number</th>
						<th class="th text-center py-3">Airline</th>
						<th class="th text-center py-3">Travel Class</th>
						<th class="th text-center py-3">Travel Date</th>
						<th class="th text-center py-3">Source</th>
						<th class="th text-center py-3">Destination</th>
						<th class="th text-center py-3">No of passengers</th>
						<th class="th text-center py-3">Total Fare</th>
						<th class="th text-center py-3">Customer Id</th>
						<th class="th text-center py-3">Booking Status</th>
					</tr>
				</thead>
				<tbody>

					<%		
			for(Reservation r : reservationList){
				
				Flight flight = cust.getFlight(r.getFlightNumber());
				String srcAirport = cust.getAirport(flight.getSource());
				String destAirport = cust.getAirport(flight.getDestination());
				String srcCountryCode = cust.getCountryCode(flight.getSource());
				String destCountryCode = cust.getCountryCode(flight.getDestination());
	%>

					<tr class="text-center">
						<td class="py-3"><%= r.getBookingId() %></td>
						<td class="py-3"><%= r.getFlightNumber()  %></td>
						<td class="py-3"><%= flight.getAirline() %></td>
						<td class="py-3"><%= r.getTravelClass() %></td>
						<td class="py-3"><%= r.getTravelDate() %></td>
						<td class="py-3"><%= srcAirport %> (<%= flight.getSource() %>)
							<b><%= srcCountryCode %></b></td>
						<td class="py-3"><%= destAirport %> (<%= flight.getDestination() %>)
							<b><%= destCountryCode %></b></td>
						<td class="py-3"><%= r.getPassengers() %></td>
						<td class="py-3"><%= r.getTotalFare() %></td>
						<td class="py-3"><%= r.getCustomerId() %></td>
						<td class="py-3">Confirmed</td>

					</tr>
					<%} }%>
				</tbody>
			</table>
		</div>

	</section>
</body>
</html>
<% } %>