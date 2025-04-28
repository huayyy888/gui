/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Product;
import model.Productrating;
import model.Receipt;
import model.ReviewService;

/**
 *
 * @author Huay
 */
@WebServlet(name = "submitReview", urlPatterns = {"/submitReview"})
public class submitReview extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
             
            String productId = request.getParameter("productId");
            String receiptId = request.getParameter("receiptId");
            int satisfaction = Integer.parseInt(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            Product product = new Product();
            product.setProductid(productId);

            Receipt receipt = new Receipt();
            receipt.setReceiptid(receiptId);

            Productrating review = new Productrating();
            review.setProductid(product);         
            review.setReceiptid(receipt);         
            review.setSatisfaction(satisfaction);
            review.setComment(comment);

            // Insert using ReviewService
            ReviewService service = new ReviewService();
            boolean success = service.insertReview(review);

            if (success) {
                response.sendRedirect("ThankYou.jsp");
            } else {
                request.setAttribute("error", "Failed to submit review.");
                request.getRequestDispatcher("ViewOrder.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error submitting review: " + e.getMessage());
            request.getRequestDispatcher("ViewOrder.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
