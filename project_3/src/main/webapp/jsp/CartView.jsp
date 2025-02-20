<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="in.co.rays.project_3.controller.CartCtl"%>
<%@page import="java.util.HashMap"%>
<%@page import="in.co.rays.project_3.util.HTMLUtility"%>
<%@page import="in.co.rays.project_3.util.DataUtility"%>
<%@page import="in.co.rays.project_3.util.ServletUtility"%>
<%@page import="in.co.rays.project_3.controller.ORSView"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User View</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="<%=ORSView.APP_CONTEXT%>/js/Utilities.js"></script>
<script src="<%=ORSView.APP_CONTEXT%>/js/Validate.js"></script>

<style type="text/css">
i.css {
	border: 2px solid #8080803b;
	padding-left: 10px;
	padding-bottom: 11px;
	background-color: #ebebe0;
}

.input-group-addon {
	background-image: linear-gradient(to bottom right, orange, black);
	background-repeat: no repeat;
	background-size: 100%;
	padding-bottom: 11px;
}

.hm {
	background-image: url('<%=ORSView.APP_CONTEXT%>/img/unsplash.jpg');
	background-size: cover;
	padding-top: 6%;
}
</style>
</head>

<body class="hm">
	<div class="header">
		<%@include file="Header.jsp"%>
		<%@include file="calendar.jsp"%>
	</div>

	<div>
		<main>
		<form action="<%=ORSView.CART_CTL%>" method="post">
			<jsp:useBean id="dto" class="in.co.rays.project_3.dto.CartDTO"
				scope="request"></jsp:useBean>

			<div class="row pt-3">
				<div class="col-md-4 mb-4"></div>
				<div class="col-md-4 mb-4">
					<div class="card input-group-addon">
						<div class="card-body">
							<%
								long id = DataUtility.getLong(request.getParameter("id"));
								if (dto.getId() != null && id > 0) {
							%>
							<h3 class="text-center default-text text-primary">Update
								Cart</h3>
							<%
								} else {
							%>
							<h3 class="text-center default-text text-primary">Add Cart</h3>
							<%
								}
							%>

							<div>
								<%
									Map map = (Map) request.getAttribute("Cart");
								%>

								<h4 align="center">
									<%
										if (!ServletUtility.getSuccessMessage(request).isEmpty()) {
									%>
									<div class="alert alert-success alert-dismissible">
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										<%=ServletUtility.getSuccessMessage(request)%>
									</div>
									<%
										}
									%>
								</h4>

								<h4 align="center">
									<%
										if (!ServletUtility.getErrorMessage(request).isEmpty()) {
									%>
									<div class="alert alert-danger alert-dismissible">
										<button type="button" class="close" data-dismiss="alert">&times;</button>
										<%=ServletUtility.getErrorMessage(request)%>
									</div>
									<%
										}
									%>
								</h4>

								<input type="hidden" name="id" value="<%=dto.getId()%>">
								<input type="hidden" name="createdBy"
									value="<%=dto.getCreatedBy()%>"> <input type="hidden"
									name="modifiedBy" value="<%=dto.getModifiedBy()%>"> <input
									type="hidden" name="createdDatetime"
									value="<%=DataUtility.getTimestamp(dto.getCreatedDatetime())%>">
								<input type="hidden" name="modifiedDatetime"
									value="<%=DataUtility.getTimestamp(dto.getModifiedDatetime())%>">
							</div>

							<!-- Customer Name -->
							<div class="md-form">
								<span class="pl-sm-5"><b>Customer Name</b> <span
									style="color: red;">*</span></span><br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-user-alt grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" class="form-control" name="customerName"
											placeholder="Customer Name"
											oninput="handleLetterInput(this, 'customerNameError', 15)"
											onblur="validateLetterInput(this, 'customerNameError', 15)"
											value="<%=DataUtility.getStringData(dto.getCustomerName())%>">
									</div>
								</div>
								<font color="red" class="pl-sm-5" id="customerNameError">
									<%=ServletUtility.getErrorMessage("customerName", request)%>
								</font><br>

								<!-- Product -->
								<span class="pl-sm-5"><b>Product</b> <span
									style="color: red;">*</span></span><br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-user-circle grey-text"
													style="font-size: 1rem;"></i>
											</div>
										</div>

										<%=HTMLUtility.getList1("product", DataUtility.getStringData(dto.getProduct()), map)%>
									</div>
								</div>
								<font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("product", request)%>
								</font> <br>

								<!-- Quantity Order -->
								<span class="pl-sm-5"><b>Quantity Order</b> <span
									style="color: red;">*</span></span><br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-user-circle grey-text"
													style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" class="form-control" name="quantityOrder"
											placeholder="Quantity Order"
											oninput="handleIntegerInput(this, 'quantityOrderError', 15)"
											onblur="validateIntegerInput(this, 'quantityOrderError', 15)"
											value="<%=DataUtility.getStringData(dto.getQuantityOrder()==0? "":dto.getQuantityOrder())%>">
									</div>
								</div>
								<font color="red" class="pl-sm-5" id="quantityOrderError">
									<%=ServletUtility.getErrorMessage("quantityOrder", request)%>
								</font><br>

								<!-- Transaction Date -->
								<span class="pl-sm-5"><b>Transaction Date</b> <span
									style="color: red;">*</span></span><br>
								<div class="col-sm-12">
									<div class="input-group">
										<div class="input-group-prepend">
											<div class="input-group-text">
												<i class="fa fa-calendar grey-text" style="font-size: 1rem;"></i>
											</div>
										</div>
										<input type="text" id="datepicker" name="transactionDate"
											class="form-control" placeholder="Transaction Date"
											readonly="readonly"
											value="<%=DataUtility.getDateString(dto.getTransactionDate())%>">
									</div>
								</div>
								<font color="red" class="pl-sm-5"> <%=ServletUtility.getErrorMessage("transactionDate", request)%>
								</font><br>

								<div class="text-center">
									<input type="submit" name="operation"
										class="btn btn-success btn-md" value="<%=CartCtl.OP_SAVE%>">
									<input type="submit" name="operation"
										class="btn btn-warning btn-md" value="<%=CartCtl.OP_RESET%>">
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</form>
		</main>
	</div>

	<%@include file="FooterView.jsp"%>
</body>
</html>
