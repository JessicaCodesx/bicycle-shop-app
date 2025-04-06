<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-user-plus"></i> Add New Customer</h1>
            <a href="customers.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Customers
            </a>
        </div>

        <% if ("error".equals(request.getParameter("status"))) { %>
        <div class="alert alert-danger">
            There was an error adding the customer. Please try again.
        </div>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-address-card"></i> Customer Information</h3>
            </div>
            <div class="card-body">
                <form method="post" action="addCustomer" id="customerForm">
                    <div class="d-flex gap-3 flex-wrap">
                        <div class="form-group" style="flex: 1; min-width: 200px;">
                            <label for="firstName">First Name <span class="text-danger">*</span></label>
                            <input type="text" id="firstName" name="firstName" required>
                        </div>
                        <div class="form-group" style="flex: 1; min-width: 200px;">
                            <label for="lastName">Last Name <span class="text-danger">*</span></label>
                            <input type="text" id="lastName" name="lastName" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Phone Number</label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-phone text-muted mr-2"></i>
                            <input type="tel" id="phoneNumber" name="phoneNumber" placeholder="e.g., 1234567890">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-envelope text-muted mr-2"></i>
                            <input type="email" id="email" name="email" placeholder="e.g., customer@example.com">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-home text-muted mr-2" style="align-self: flex-start; margin-top: 12px;"></i>
                            <textarea id="address" name="address" rows="3" placeholder="Street, City, State, ZIP"></textarea>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-save"></i> Add Customer
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.getElementById('customerForm').addEventListener('submit', function(e) {
        const firstName = document.getElementById('firstName').value.trim();
        const lastName = document.getElementById('lastName').value.trim();
        const email = document.getElementById('email').value.trim();

        if (!firstName || !lastName) {
            e.preventDefault();
            alert('First name and last name are required!');
            return false;
        }

        if (email && !isValidEmail(email)) {
            e.preventDefault();
            alert('Please enter a valid email address.');
            return false;
        }

        return true;
    });

    function isValidEmail(email) {
        const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(email);
    }

    document.querySelectorAll('.mr-2').forEach(el => {
        el.style.marginRight = '10px';
    });
</script>
</body>
</html>