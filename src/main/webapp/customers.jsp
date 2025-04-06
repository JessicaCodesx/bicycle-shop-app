<%@ page import="java.util.*, com.jessica.bicycleshopapp.dao.CustomerDAO, com.jessica.bicycleshopapp.model.Customer" %>
<%
    List<Customer> customers = new CustomerDAO().getAllCustomers();
    String role = ((com.jessica.bicycleshopapp.model.User) session.getAttribute("user")).getRole().toLowerCase();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customers - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-users"></i> Customer Management</h1>
            <a href="add-customer.jsp" class="btn">
                <i class="fas fa-user-plus"></i> Add New Customer
            </a>
        </div>

        <% if ("success".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success">
            Customer added successfully!
        </div>
        <% } else if ("deleted".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success">
            Customer deleted successfully!
        </div>
        <% } else if ("updated".equals(request.getParameter("status"))) { %>
        <div class="alert alert-success">
            Customer information updated successfully!
        </div>
        <% } %>

        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h3><i class="fas fa-list"></i> Customer List</h3>
                <div class="d-flex align-items-center">
                    <input type="text" id="customerSearch" onkeyup="filterCustomers()"
                           placeholder="Search customers..." class="form-control" style="width: 250px; margin-right: 10px;">
                    <span class="text-muted" id="customerCount"><%= customers.size() %> customers</span>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table id="customersTable">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Phone</th>
                            <th>Email</th>
                            <th>Address</th>
                            <% if ("admin".equals(role) || "owner".equals(role)) { %>
                            <th>Actions</th>
                            <% } %>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Customer c : customers) { %>
                        <tr>
                            <td><%= c.getCustomerId() %></td>
                            <td><%= c.getFirstName() %> <%= c.getLastName() %></td>
                            <td><%= c.getPhoneNumber() != null ? c.getPhoneNumber() : "-" %></td>
                            <td><%= c.getEmail() != null ? c.getEmail() : "-" %></td>
                            <td><%= c.getAddress() != null ? c.getAddress() : "-" %></td>
                            <% if ("admin".equals(role) || "owner".equals(role)) { %>
                            <td>
                                <div class="table-actions">
                                    <a href="edit-customer.jsp?id=<%= c.getCustomerId() %>" class="action-btn edit">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <form method="post" action="deleteCustomer" onsubmit="return confirm('Are you sure you want to delete this customer?');" style="display:inline;">
                                        <input type="hidden" name="id" value="<%= c.getCustomerId() %>">
                                        <button type="submit" class="action-btn delete">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                    <a href="customer-details.jsp?id=<%= c.getCustomerId() %>" class="action-btn view">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                </div>
                            </td>
                            <% } %>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    function filterCustomers() {
        var input = document.getElementById("customerSearch");
        var filter = input.value.toLowerCase();

        var table = document.getElementById("customersTable");
        var rows = table.getElementsByTagName("tr");

        var visibleCount = 0;

        for (var i = 1; i < rows.length; i++) {
            var showRow = false;
            var cells = rows[i].getElementsByTagName("td");

            for (var j = 0; j < cells.length; j++) {
                var cell = cells[j];

                if (cell) {
                    var cellText = cell.textContent || cell.innerText;

                    if (cellText.toLowerCase().indexOf(filter) > -1) {
                        showRow = true;
                        break;
                    }
                }
            }

            rows[i].style.display = showRow ? "" : "none";

            if (showRow) visibleCount++;
        }

        document.getElementById("customerCount").innerText = visibleCount + " customers";
    }
</script>
</body>
</html>