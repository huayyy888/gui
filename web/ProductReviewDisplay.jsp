<%@ page import="java.util.*, model.*" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ include file="header.jsp" %>

<%
    ReviewService reviewService = new ReviewService();
    ProductDa productService = new ProductDa();

    List<String> productIds = reviewService.getProductIdsWithRatings(1); // get all products with at least 1 rating
%>

<!DOCTYPE html>
<html>
<head>
    <title>Product Ratings</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            padding: 30px;
            background-color: #f9f9f9;
        }

        .product-box {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .rating {
            color: #f5c518;
            font-size: 16px;
        }

        .review-comment {
            margin: 8px 0;
            padding-left: 10px;
            border-left: 3px solid #eee;
            font-style: italic;
        }

        .review-date {
            font-size: 12px;
            color: #888;
        }
    </style>
</head>
<body>

<h2>All Product Ratings</h2>

<%
    for (String pid : productIds) {
        Product product = productService.getProductById(pid);
        double avg = reviewService.getAverageRating(pid);
        int count = reviewService.getReviewCount(pid);
        List<Productrating> allReviews = reviewService.getReviewsByProductId(pid); // ⭐ Fetch ALL reviews
%>

<div class="product-box">
    <div style="display: flex; gap: 20px; align-items: flex-start;">
        <!-- Product Image -->
        <img src="imgUpload/<%= product.getImglocation()%>" alt="Product Image" width="100" height="100" style="object-fit: cover; border-radius: 8px;" />

        <!-- Product Info -->
        <div style="flex: 1;">
            <h3 style="margin: 0 0 5px;"><%= product.getProductname() %></h3>
            <div class="rating">
                <%
                    int stars = (int) avg;
                    boolean half = (avg - stars) >= 0.5;
                    for (int i = 0; i < stars; i++) { out.print("★"); }
                    if (half) { out.print("½"); }
                    for (int i = stars + (half ? 1 : 0); i < 5; i++) { out.print("☆"); }
                %>
                (<%= String.format("%.1f", avg) %> from <%= count %> review<%= count != 1 ? "s" : "" %>)
            </div>

            <% for (Productrating r : allReviews) { %>
                <div class="review-comment">
                    <%= r.getComment() %>
                    <div class="review-date">Reviewed on <%= r.getRatingdate() %></div>

                    <% if (r.getReply() != null && !r.getReply().trim().isEmpty()) { %>
                    <div style="margin-top: 8px; color: #2f855a; font-style: italic;">
                        <strong>Reply:</strong> <%= r.getReply() %>
                    </div>
                    <% } %>
                </div>
            <% } %>

        </div>
    </div>
</div>

<% } %>  
</body>
</html>
