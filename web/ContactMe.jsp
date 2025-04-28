<%-- 
    Document   : ContactMe
    Created on : Apr 14, 2025, 10:28:51 PM
    Author     : Huay
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact Me</title>
        <link rel="stylesheet" type="text/css" href="src/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="src/css/style.css">
        <link rel="stylesheet" href="src/css/responsive.css">
        <link rel="stylesheet" href="src/css/jquery.mCustomScrollbar.min.css">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/owl-carousel/1.3.3/owl.carousel.css" rel="stylesheet" />

        <!-- font-->
        <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
        <link href="https://fonts.googleapis.com/css?family=Poppins:400,700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="contact_section layout_padding">
            <div class="container-fluid">
                <h1 class="contact_taital">Contact Us</h1>
                <div class="contact_section_2">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="image_7"><img src="src/image/prod-home1.png"></div>
                        </div>
                        <div class="col-md-6">
                            <div class="mail_section_1">
                                <input type="text" class="mail_text" placeholder="Your Name" name="Your Name">
                                <input type="text" class="mail_text" placeholder="Phone Number" name="Phone Number">
                                <input type="text" class="mail_text" placeholder="Email" name="Email">
                                <textarea class="massage-bt" placeholder="Massage" rows="5" id="comment" name="Massage"></textarea>
                                <div class="send_bt"><a href="#">SEND</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
