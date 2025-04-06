<%@ include file="navbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order New Inventory - Bike Shop System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

<div class="container">
    <div class="wrapper">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-truck-loading"></i> Order New Inventory</h1>
            <a href="dashboard.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <div class="card">
            <div class="card-header">
                <h3><i class="fas fa-clipboard-list"></i> Order Details</h3>
            </div>
            <div class="card-body">
                <form method="post" action="order-product" id="orderForm">
                    <div class="form-group">
                        <label for="productId">Product ID <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-barcode text-muted mr-2"></i>
                            <input type="number" name="productId" id="productId" required placeholder="Enter product ID">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="supplierId">Supplier ID <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-truck text-muted mr-2"></i>
                            <input type="number" name="supplierId" id="supplierId" required placeholder="Enter supplier ID">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="quantity">Quantity <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-box text-muted mr-2"></i>
                            <input type="number" name="quantity" id="quantity" required placeholder="Enter quantity">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="orderDate">Order Date <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-calendar-alt text-muted mr-2"></i>
                            <input type="date" name="orderDate" id="orderDate" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="deliveryDate">Expected Delivery Date <span class="text-danger">*</span></label>
                        <div class="d-flex align-items-center">
                            <i class="fas fa-calendar-check text-muted mr-2"></i>
                            <input type="date" name="deliveryDate" id="deliveryDate" required>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end gap-2 mt-4">
                        <button type="reset" class="btn btn-warning">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-success">
                            <i class="fas fa-paper-plane"></i> Submit Order
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        document.querySelectorAll('.mr-2').forEach(el => {
            el.style.marginRight = '10px';
        });
    });
</script>

</body>
</html>
