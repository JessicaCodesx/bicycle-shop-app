<%@ page import="java.sql.*, java.util.*, com.jessica.bicycleshopapp.util.DBUtil" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    String start = request.getParameter("start");
    String end = request.getParameter("end");

    List<Map<String, Object>> sales = new ArrayList<>();
    double totalSales = 0.0;
    int totalTransactions = 0;
    double avgSale = 0.0;
    Date maxDate = null;
    double maxDaySales = 0.0;

    java.sql.Date today = new java.sql.Date(System.currentTimeMillis());

    Calendar cal = Calendar.getInstance();
    cal.add(Calendar.DATE, -30);
    java.sql.Date thirtyDaysAgo = new java.sql.Date(cal.getTimeInMillis());

    String formattedStart = start != null ? start : new SimpleDateFormat("yyyy-MM-dd").format(thirtyDaysAgo);
    String formattedEnd = end != null ? end : new SimpleDateFormat("yyyy-MM-dd").format(today);

    if (formattedStart != null && formattedEnd != null) {
        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                    "SELECT SaleDate, SUM(Cost) AS TotalSales, COUNT(*) AS TransactionCount " +
                            "FROM SALES " +
                            "WHERE SaleDate BETWEEN ? AND ? " +
                            "GROUP BY SaleDate " +
                            "ORDER BY SaleDate"
            );

            ps.setDate(1, Date.valueOf(formattedStart));
            ps.setDate(2, Date.valueOf(formattedEnd));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();

                java.sql.Date saleDate = rs.getDate("SaleDate");
                double daySales = rs.getDouble("TotalSales");
                int dayTransactions = rs.getInt("TransactionCount");

                row.put("date", saleDate);
                row.put("total", daySales);
                row.put("transactions", dayTransactions);

                totalSales += daySales;
                totalTransactions += dayTransactions;

                if (maxDate == null || daySales > maxDaySales) {
                    maxDate = saleDate;
                    maxDaySales = daySales;
                }

                sales.add(row);
            }

            if (totalTransactions > 0) {
                avgSale = totalSales / totalTransactions;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    SimpleDateFormat displayDateFormat = new SimpleDateFormat("MMM dd, yyyy");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Report - Bike Shop System</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
</head>
<body>
<%@ include file="navbar.jsp" %>

<div class="container">
    <div class="wrapper">
        <h1><i class="fas fa-chart-line"></i> Sales Report</h1>

        <div class="d-flex justify-content-end mb-3">
            <a href="dashboard.jsp" class="btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <div class="card mb-4">
            <div class="card-header">
                <h3><i class="fas fa-filter"></i> Report Parameters</h3>
            </div>
            ...

            <div class="card-body">
                <form method="get" class="d-flex flex-wrap gap-3 align-items-end">
                    <div class="form-group" style="flex: 1; min-width: 200px;">
                        <label for="start">From Date</label>
                        <input type="date" id="start" name="start" value="<%= formattedStart %>" required>
                    </div>

                    <div class="form-group" style="flex: 1; min-width: 200px;">
                        <label for="end">To Date</label>
                        <input type="date" id="end" name="end" value="<%= formattedEnd %>" required>
                    </div>

                    <button type="submit" class="btn">
                        <i class="fas fa-search"></i> Generate Report
                    </button>

                    <button type="button" id="printBtn" class="btn" onclick="window.print();">
                        <i class="fas fa-print"></i> Print Report
                    </button>
                </form>
            </div>
        </div>

        <% if (sales.size() > 0) { %>
        <div class="report-result">
            <div class="stats-container mb-4">
                <div class="stat-card">
                    <i class="fas fa-dollar-sign fa-2x mb-3 text-primary"></i>
                    <div class="stat-value">$<%= String.format("%.2f", totalSales) %></div>
                    <div class="stat-label">Total Sales</div>
                </div>

                <div class="stat-card">
                    <i class="fas fa-shopping-cart fa-2x mb-3 text-primary"></i>
                    <div class="stat-value"><%= totalTransactions %></div>
                    <div class="stat-label">Transactions</div>
                </div>

                <div class="stat-card">
                    <i class="fas fa-calculator fa-2x mb-3 text-primary"></i>
                    <div class="stat-value">$<%= String.format("%.2f", avgSale) %></div>
                    <div class="stat-label">Avg. Sale</div>
                </div>

                <div class="stat-card">
                    <i class="fas fa-trophy fa-2x mb-3 text-primary"></i>
                    <div class="stat-value">$<%= String.format("%.2f", maxDaySales) %></div>
                    <div class="stat-label">Best Day: <%= maxDate != null ? displayDateFormat.format(maxDate) : "N/A" %></div>
                </div>
            </div>

            <!-- Sales chart -->
            <div class="card mb-4">
                <div class="card-header">
                    <h3><i class="fas fa-chart-bar"></i> Sales Trend</h3>
                </div>
                <div class="card-body">
                    <canvas id="salesChart" height="300"></canvas>
                </div>
            </div>

            <!-- Detailed sales table -->
            <div class="card">
                <div class="card-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <h3><i class="fas fa-table"></i> Detailed Results</h3>
                        <h4>Period: <%= displayDateFormat.format(Date.valueOf(formattedStart)) %> to <%= displayDateFormat.format(Date.valueOf(formattedEnd)) %></h4>
                    </div>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table>
                            <thead>
                            <tr>
                                <th>Date</th>
                                <th>Transactions</th>
                                <th>Sales Amount</th>
                            </tr>
                            </thead>
                            <tbody>
                            <% for (Map<String, Object> row : sales) { %>
                            <tr>
                                <td><%= displayDateFormat.format(row.get("date")) %></td>
                                <td><%= row.get("transactions") %></td>
                                <td>$<%= String.format("%.2f", row.get("total")) %></td>
                            </tr>
                            <% } %>
                            <tr class="text-primary" style="font-weight: bold;">
                                <td>Total</td>
                                <td><%= totalTransactions %></td>
                                <td>$<%= String.format("%.2f", totalSales) %></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <% } else if (formattedStart != null && formattedEnd != null) { %>
        <div class="alert alert-info mt-4">
            No sales found in this date range.
        </div>
        <% } %>
    </div>
</div>

<%@ include file="footer.jsp" %>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        <% if (sales.size() > 0) { %>
        const dates = [];
        const salesData = [];
        const transactionData = [];

        <% for (Map<String, Object> row : sales) {
            Date saleDate = (Date)row.get("date");
            String formattedDate = new SimpleDateFormat("MMM dd").format(saleDate);
        %>
        dates.push('<%= formattedDate %>');
        salesData.push(<%= row.get("total") %>);
        transactionData.push(<%= row.get("transactions") %>);
        <% } %>

        const ctx = document.getElementById('salesChart').getContext('2d');
        const salesChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: dates,
                datasets: [
                    {
                        label: 'Sales Amount ($)',
                        data: salesData,
                        backgroundColor: 'rgba(52, 152, 219, 0.6)',
                        borderColor: 'rgba(52, 152, 219, 1)',
                        borderWidth: 1,
                        yAxisID: 'y'
                    },
                    {
                        label: 'Transactions',
                        data: transactionData,
                        type: 'line',
                        backgroundColor: 'rgba(231, 76, 60, 0.2)',
                        borderColor: 'rgba(231, 76, 60, 1)',
                        borderWidth: 2,
                        pointRadius: 4,
                        tension: 0.2,
                        yAxisID: 'y1'
                    }
                ]
            },
            options: {
                responsive: true,
                interaction: {
                    mode: 'index',
                    intersect: false,
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        position: 'left',
                        title: {
                            display: true,
                            text: 'Sales Amount ($)'
                        }
                    },
                    y1: {
                        beginAtZero: true,
                        position: 'right',
                        grid: {
                            drawOnChartArea: false,
                        },
                        title: {
                            display: true,
                            text: 'Transaction Count'
                        }
                    }
                }
            }
        });
        <% } %>

        document.querySelector('form').addEventListener('submit', function(e) {
            const startDate = new Date(document.getElementById('start').value);
            const endDate = new Date(document.getElementById('end').value);

            if (startDate > endDate) {
                e.preventDefault();
                alert('Start date cannot be later than end date.');
            }
        });
    });
</script>

<style>
    @media print {
        .navbar, .footer, .btn, form {
            display: none !important;
        }
        .wrapper {
            box-shadow: none !important;
            margin: 0 !important;
            padding: 0 !important;
        }
        body {
            background: white !important;
        }
    }
</style>
</body>
</html>