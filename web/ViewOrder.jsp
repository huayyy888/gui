<%@ page import="model.CartService" %>
<%@ page import="model.CartItem" %>
<%@ page import="model.Product" %>
<%@ page import="model.Receipt" %>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<%
    String custId = (String) session.getAttribute("custId");
    if (custId == null) {
        response.sendRedirect("CustomerLogin.jsp");
        return;
    }

    String receiptId = request.getParameter("receiptId");
    CartService cartService = new CartService();
    Receipt receipt = cartService.getReceiptById(receiptId);
    List<CartItem> items = cartService.getCartItemsByReceiptId(receiptId);

    BigDecimal subtotal = BigDecimal.ZERO;
    for (CartItem item : items) {
        subtotal = subtotal.add(item.getPrice().multiply(BigDecimal.valueOf(item.getQuantitypurchased())));
    }

    BigDecimal tax = subtotal.multiply(BigDecimal.valueOf(0.06));
    BigDecimal shipping = subtotal.compareTo(BigDecimal.valueOf(1000)) < 0 ? new BigDecimal("25.00") : BigDecimal.ZERO;
    BigDecimal discount = receipt.getDiscount() != null ? receipt.getDiscount() : BigDecimal.ZERO;
    BigDecimal total = receipt.getTotal();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Details</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 20px;
        }
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #f8f8f8;
        }
        .total {
            font-weight: bold;
            text-align: right;
            padding-right: 30px;
        }
        h2 {
            text-align: center;
        }
        img {
            max-width: 80px;
        }
        
        .btn-review {
            background-color: #6366f1; /* Tailwind's indigo-500 */
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s ease-in-out;
        }

        .btn-review:hover {
            background-color: #4f46e5; /* Tailwind's indigo-600 */
            transform: translateY(-1px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
        }
        
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5); /* dark transparent background */
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            position: relative;
            text-align: center;
        }

        .close {
            position: absolute;
            right: 20px;
            top: 20px;
            font-size: 24px;
            font-weight: bold;
            color: #999;
            cursor: pointer;
        }

        .close:hover {
            color: black;
        }
        
        .star-rating {
            direction: rtl;
            display: flex;
            justify-content: flex-start;
            font-size: 2em;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            color: #ccc;
            cursor: pointer;
            transition: color 0.2s;
        }
        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #ffc107;
        }
        textarea {
            width: 100%;
            resize: none;
            margin-top: 10px;
        }


    </style>
</head>
<body>

<h2>Order Summary</h2>
<p style="text-align: center;">
    Receipt ID: <strong><%= receipt.getReceiptid() %></strong> |
    Date: <%= receipt.getCreationtime() %>
</p>

<% if (items != null && !items.isEmpty()) { %>
    <table>
        <tr>
            <th>Product</th>
            <th>Price (RM)</th>
            <th>Quantity</th>
            <th>Subtotal (RM)</th>
            <th>Action</th>
        </tr>

        <% for (CartItem item : items) {
            Product product = item.getProductid();
            BigDecimal sub = item.getPrice().multiply(BigDecimal.valueOf(item.getQuantitypurchased()));
        %>
        <tr>
            <td>
                <img src="imgUpload/<%= item.getProductid().getImglocation()%>" width="80"><br>
                <%= item.getProductid().getProductname()%>
            </td>
            <td><%= item.getPrice().setScale(2) %></td>
            <td><%= item.getQuantitypurchased() %></td>
            <td><%= sub.setScale(2) %></td>
            <td>
                <button type="button" class="btn-review" onclick="openReviewModal('<%= product.getProductid()%>', '<%= receipt.getReceiptid()%>')">
                    ✍️ Write a Review
                </button>
            </td>
        </tr>
        <% } %>

        <tr>
            <td colspan="3" class="total">Subtotal:</td>
            <td colspan="2">RM <%= subtotal.setScale(2) %></td>
        </tr>
        <% if (discount != null && discount.compareTo(BigDecimal.ZERO) > 0) {%>
        <tr>
            <td colspan="3" class="total">
                Voucher Applied:
                <%= (receipt.getVoucherCode() != null) ? receipt.getVoucherCode() : ""%>
            </td>
            <td colspan="2" style="color: green;">
                - RM <%= String.format("%.2f", discount)%>
            </td>
        </tr>
        <% }%>
        <tr>
            <td colspan="3" class="total">Sales Tax (6%):</td>
            <td colspan="2">RM <%= tax.setScale(2) %></td>
        </tr>
        <tr>
            <td colspan="3" class="total">
                Shipping:
                <% if (shipping.compareTo(BigDecimal.ZERO) == 0) { %>
                    <span style="color: green;">(Free over RM1000)</span>
                <% } %>
            </td>
            <td colspan="2">RM <%= shipping.setScale(2) %></td>
        </tr>
        <tr>
            <td colspan="3" class="total">Total Paid:</td>
            <td colspan="2"><strong>RM <%= total.setScale(2) %></strong></td>
        </tr>
    </table>
        
        <!-- Review Modal -->
        <div id="reviewModal" class="modal" style="display: none;">
            <div class="modal-content">
                <span class="close" onclick="closeReviewModal()">&times;</span>
                <h2>Write a Review</h2>
                <form action="submitReview" method="post" id="reviewForm">
                    <input type="hidden" name="productId" id="reviewProductId">
                    <input type="hidden" name="receiptId" id="reviewReceiptId">

                    <div class="star-rating" style="display: flex; justify-content: center; font-size: 2em; direction: rtl; margin: 20px 0;">
                        <input type="radio" id="star5" name="rating" value="5" required><label for="star5">&#9733;</label>
                        <input type="radio" id="star4" name="rating" value="4"><label for="star4">&#9733;</label>
                        <input type="radio" id="star3" name="rating" value="3"><label for="star3">&#9733;</label>
                        <input type="radio" id="star2" name="rating" value="2"><label for="star2">&#9733;</label>
                        <input type="radio" id="star1" name="rating" value="1"><label for="star1">&#9733;</label>
                    </div>

                    <textarea name="comment" rows="5" maxlength="200" style="width: 100%;" placeholder="Write your comment..." required></textarea>

                    <button type="submit" class="btn-review" style="margin-top: 20px;">Submit Review</button>
                </form>
            </div>
        </div>

            
<% } else { %>
    <p style="text-align: center; color: #999;">No products found in this receipt.</p>
<% } %>

<script>
function openReviewModal(productId, receiptId) {
    document.getElementById('reviewModal').style.display = 'flex';
    document.getElementById('reviewProductId').value = productId;
    document.getElementById('reviewReceiptId').value = receiptId;
}

function closeReviewModal() {
    document.getElementById('reviewModal').style.display = 'none';
}
</script>

</body>
</html>
