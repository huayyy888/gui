package model;

import model.Product;
import model.Productrating;
import model.Receipt;
import controller.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewService {

    public String generateNextRatingId(Connection conn) throws SQLException {
        String nextId = "rat001";
        String sql = "SELECT ratingId FROM productRating ORDER BY ratingId DESC FETCH FIRST 1 ROWS ONLY";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                String lastId = rs.getString("ratingId");
                int num = Integer.parseInt(lastId.substring(3)) + 1;
                nextId = "rat" + String.format("%03d", num);
            }
        }
        return nextId;
    }

    public boolean insertReview(Productrating review) throws Exception {
        try (Connection conn = DBConnection.getConnection()) {
            String newId = generateNextRatingId(conn);
            review.setRatingid(newId);

            String sql = "INSERT INTO productRating (ratingId, receiptId, productId, ratingDate, satisfaction, comment) "
                    + "VALUES (?, ?, ?, CURRENT_TIMESTAMP, ?, ?)";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, review.getRatingid());
                ps.setString(2, review.getReceiptid().getReceiptid());
                ps.setString(3, review.getProductid().getProductid());
                ps.setInt(4, review.getSatisfaction());
                ps.setString(5, review.getComment());
                return ps.executeUpdate() > 0;
            }
        }
    }
    
    public List<Productrating> getReviewsByProductId(String productId) {
        List<Productrating> reviews = new ArrayList<>();

        String sql = "SELECT ratingId, satisfaction, comment,reply, ratingDate FROM productRating WHERE productId = ? ORDER BY ratingDate DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Productrating r = new Productrating();
                r.setRatingid(rs.getString("ratingId"));
                r.setSatisfaction(rs.getInt("satisfaction"));
                r.setReply(rs.getString("reply"));
                r.setComment(rs.getString("comment"));
                r.setRatingdate(rs.getTimestamp("ratingDate"));
  

                reviews.add(r);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reviews;
    }
    
    public List<Productrating> getReviewsByCustomer(String custId) {
        List<Productrating> list = new ArrayList<>();

        String sql = "SELECT pr.ratingId, pr.ratingDate, pr.satisfaction, pr.comment, pr.reply, "
                + "p.productId, p.productName, p.imgLocation "
                + "FROM productRating pr "
                + "JOIN receipt r ON pr.receiptId = r.receiptId "
                + "JOIN cart c ON r.cartId = c.cartId "
                + "JOIN product p ON pr.productId = p.productId "
                + "WHERE c.custId = ? ORDER BY pr.ratingDate DESC";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, custId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Productrating review = new Productrating();
                review.setRatingid(rs.getString("ratingId"));
                review.setRatingdate(rs.getTimestamp("ratingDate"));
                review.setSatisfaction(rs.getInt("satisfaction"));
                review.setComment(rs.getString("comment"));
                review.setReply(rs.getString("reply"));

                Product product = new Product();
                product.setProductid(rs.getString("productId"));
                product.setProductname(rs.getString("productName"));
                product.setImglocation(rs.getString("imgLocation"));
                review.setProductid(product);

                list.add(review);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public double getAverageRating(String productId) {
        double avg = 0.0;
        String sql = "SELECT AVG(satisfaction) AS avgRating FROM productRating WHERE productId = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                avg = rs.getDouble("avgRating");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return avg;
    }
    
    public int getReviewCount(String productId) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total FROM productRating WHERE productId = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, productId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }
    
    public List<String> getProductIdsWithRatings(int minimumReviews) {
        List<String> productIds = new ArrayList<>();
        String sql = "SELECT productId FROM productRating GROUP BY productId HAVING COUNT(*) >= ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, minimumReviews);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                productIds.add(rs.getString("productId"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return productIds;
    }

    
    public List<Productrating> getTop3ReviewsByProduct(String productId) {
        List<Productrating> list = new ArrayList<>();

        String sql = "SELECT ratingId, satisfaction, comment, reply, ratingDate FROM productRating "
                + "WHERE productId = ? ORDER BY ratingDate DESC FETCH FIRST 3 ROWS ONLY";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Productrating pr = new Productrating();
                pr.setRatingid(rs.getString("ratingId"));
                pr.setRatingdate(rs.getTimestamp("ratingDate"));
                pr.setSatisfaction(rs.getInt("satisfaction"));
                pr.setComment(rs.getString("comment"));
                pr.setReply(rs.getString("reply"));  // ✅ Include reply here
                list.add(pr);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    
    public List<Productrating> getAllRatings() {
        List<Productrating> ratings = new ArrayList<>();
        String sql = "SELECT * FROM productRating";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Productrating rating = new Productrating();
                rating.setRatingid(rs.getString("ratingId"));
                rating.setSatisfaction(rs.getInt("satisfaction"));
                rating.setComment(rs.getString("comment"));
                rating.setReply(rs.getString("reply"));
                rating.setRatingdate(rs.getTimestamp("ratingDate"));

                // Set product & receipt as dummy for now
                Product product = new Product();
                product.setProductid(rs.getString("productId"));
                rating.setProductid(product);

                Receipt receipt = new Receipt();
                receipt.setReceiptid(rs.getString("receiptId"));
                rating.setReceiptid(receipt);

                ratings.add(rating);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ratings;
    }


    public void updateReply(String ratingId, String replyText) {
        String sql = "UPDATE productRating SET reply = ? WHERE ratingId = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, replyText);
            stmt.setString(2, ratingId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    
}