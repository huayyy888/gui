/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
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
@WebServlet(name = "EditProdServlet", urlPatterns = {"/EditProdServlet"})
@MultipartConfig // 
public class EditProdServlet extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    
    @Resource
    UserTransaction utx;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String prodId=request.getParameter("prodId");

        ProdService prodService = new ProdService(em);

        //extra - check exist before delete product from db
        //make sure product exist if want to perform delete
        boolean prodExist=prodService.productExists(prodId);


        try {
            if(prodExist){
                //get all the details and store inside object
                Product prod = prodService.findProduct(prodId);
                
                //get the all the details based on id and pass the request to editProd jsp
                //set session editProd=prod
                HttpSession session = request.getSession();
                session.setAttribute("editProd", prod); //data before edit(ori data)

                //forward to editProd jsp if exist
                RequestDispatcher rd = request.getRequestDispatcher("editProd.jsp");
                rd.forward(request, response);

            }else{
                //show alert - tell user prod not exist
                out.println("<script type=\"text/javascript\">");
                out.println("alert('Product no exist!');");
                out.println("</script>");
                RequestDispatcher rd = request.getRequestDispatcher("AddProdServlet");
                rd.forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
     
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
 
        String prodId=request.getParameter("prodId");
        String prodName=request.getParameter("prodName");
        double prodPrice = Double.parseDouble(request.getParameter("prodPrice"));
        int prodStock=Integer.parseInt(request.getParameter("prodStock"));
        String prodCat=request.getParameter("prodCat");
        String prodDesc=request.getParameter("prodDesc");
        int prodStatus=Integer.parseInt(request.getParameter("prodStatus"));

        //current upload button
        String mdfName;
        Part imgPath=request.getPart("prodImage");


        //old image
        String oldImgName = request.getParameter("oldProdImage");

        //make directory called /imgUpload if doesnt exist
        String uploadDirectory = getServletContext().getRealPath("/imgUpload");
        File uploadDir = new File(uploadDirectory);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Save new image and delete old one
        if (imgPath != null && imgPath.getSize() > 0) { //if user got upload
            File oldImageFile = new File(uploadDir, oldImgName);

            if (oldImageFile.exists()) { //delete existing file if exist
                oldImageFile.delete();
            }
            
            String imgName = Paths.get(imgPath.getSubmittedFileName()).getFileName().toString();

            String extension = imgName.substring(imgName.lastIndexOf("."));
            mdfName=prodId+extension;
            //then store the new uploaded image
            Path storeImg = Paths.get(uploadDirectory, mdfName);
            //Files.copy(imgPath.getInputStream(), storeImg, StandardCopyOption.REPLACE_EXISTING);
            Files.copy(imgPath.getInputStream(), storeImg);

        } else { //if user doesnt upload (indicate user doesnt want change image)
            // Use old image name if no new one is uploaded
            mdfName = oldImgName;
        }

        // Update product
        ProdService prodService = new ProdService(em);
            
        try{    

            Product prod = prodService.findProduct(prodId);
            //out.println("<script>alert('Update: " + (prod==null) + "');</script>");
            if (prod == null) {
                out.println("<script>alert('Update failed1: " + prod + "');</script>");
                out.println("<script>alert('Product not found!');</script>");
                return;
            }

            
            prod.setProductname(prodName);
            prod.setPrice(BigDecimal.valueOf(prodPrice));
            prod.setQuantity(prodStock);
            prod.setProductdescription(prodDesc);
            prod.setStatus(prodStatus);
            prod.setImglocation(mdfName);
            prod.setCategory(prodCat);

            utx.begin();
            prodService.updateProduct(prod);
            utx.commit();
            
            //create a session for product(viewProd.jsp)
            ProductDa pda=new ProductDa();
            List<Product> prodList = pda.getAllProd();
            HttpSession session = request.getSession();
            //add admin staff session

            //set the prodlist session
            session.setAttribute("prodList", prodList);
            session.setAttribute("filterList", prodList);//extra

            out.println("<script>alert('Update Successfully!');</script>");
            RequestDispatcher rd = request.getRequestDispatcher("viewProd.jsp");
            rd.forward(request, response);

        } catch (Exception ex) {
            out.println("<html><head><script type=\"text/javascript\">");
            out.println("alert('Update failed: " + ex.getMessage() + "');");
            out.println("window.location.href = 'viewProd.jsp';");
            out.println("</script></head><body></body></html>");
        }
   
        
    }


}


