/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.transaction.UserTransaction;
import model.ProdService;
import model.Product;
import model.ProductDa;

/**
 *
 * @author Mei Yen
 */
@WebServlet(name = "AddProdServlet", urlPatterns = {"/AddProdServlet"})
@MultipartConfig // 
public class AddProdServlet extends HttpServlet {
    
    @PersistenceContext
    EntityManager em;

    @Resource
    UserTransaction utx;
    
    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
        
            String prodId=request.getParameter("prodId");
            String prodName=request.getParameter("prodName");
            double prodPrice = Double.parseDouble(request.getParameter("prodPrice"));
            int prodStock=Integer.parseInt(request.getParameter("prodStock"));
            String prodCat=request.getParameter("prodCat");
            String prodDesc=request.getParameter("prodDesc");
            int prodStatus=Integer.parseInt(request.getParameter("prodStatus"));

            //obtain image path
            //retrieves the uploaded file from the HTTP request
            Part imgPath=request.getPart("prodImage");

            //obtain file name
            String imgName = Paths.get(imgPath.getSubmittedFileName()).getFileName().toString();
            
            //extension
            String extension = imgName.substring(imgName.lastIndexOf("."));
            
//            String mdfName=prodId+"_"+imgName;
            String mdfName=prodId+extension;

            InputStream imgContent = imgPath.getInputStream();

            // Construct the path to store the images
            String uploadDirectory = getServletContext().getRealPath("/imgUpload");
    
            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();

            }

            // Save the images to the folder
            Path storeImg = Paths.get(uploadDirectory, mdfName);
            Files.copy(imgContent, storeImg);

            Product prod = new Product(prodId,prodName,mdfName,prodPrice,prodStock,prodCat,prodDesc,prodStatus);
        
        
            ProdService prodService = new ProdService(em);
            ProductDa pda=new ProductDa();

            //extra - check exist before add product to db
            //make sure product added no duplicate
            boolean insertStatus=pda.addProduct(prod);

            if(insertStatus){
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Successful to add new product! Product (" + prodId + ")');");
                out.println("</script>");
                List<Product> prodList = pda.getAllProd();
                HttpSession session = request.getSession();

                //set the prodlist session
                session.setAttribute("prodList", prodList);
                //out.write("setTimeout(function(){window.location.href='viewProd.jsp'},5000);");
//                RequestDispatcher rd = request.getRequestDispatcher("viewProd.jsp");//
//                rd.forward(request, response);
                response.sendRedirect("AddProdServlet");
            }else{
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Failed to add new product! Product (" + prodId + ") already exists in the database!');");
                out.println("</script>");
                response.sendRedirect("addProduct.jsp?error=Failed to add new product! Product (" + prodId + ") already exists in the database!");
                
            }
            

        }catch(NullPointerException np){
            out.println("<script>alert('ERROR: " + np.getMessage() + "');</script>");
            response.sendRedirect("addProduct.jsp?error=Please fill in all input field.");
                
        }catch (Exception ex) {
            response.sendRedirect("AddProdServlet");

        }
        
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductDa pda=new ProductDa();
            List<Product> prodList = pda.getAllProd();
            HttpSession session = request.getSession();
            
            //remove filterlist before proceed to viewProd.jsp since user doesnt perform search
            session.removeAttribute("filterList");
            
            //set the prodlist session
            session.setAttribute("prodList", prodList);
            
            response.sendRedirect("viewProd.jsp");

        } catch (Exception ex) {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("ERROR: " + ex.getMessage());
            ex.printStackTrace();
        }
    }

}