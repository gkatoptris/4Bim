<%-- 
    Document   : index
    Created on : 23/09/2020, 12:05:10
    Author     : Giovana
--%>

<%@page import="config.Conexao"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/css.css">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <title>JSP Page</title>
    </head>
        <%
            Statement st = null;
            ResultSet rs = null;
        %>
    
    <body>
        <div id="login">
            <h3 class="text-center text-white pt-5">Login form</h3>
            <div class="container">
                <div id="login-row" class="row justify-content-center align-items-center">
                    <div id="login-column" class="col-md-6">
                        <div id="login-box" class="col-md-12">
                            <form id="login-form" class="form" action="index.jsp" method="post">
                                <h3 class="text-center text-info">Login</h3>
                                <div class="form-group">
                                    <label for="username" class="text-info">Email</label><br>
                                    <input type="text" name="email" id="username" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="password" class="text-info">Senha</label><br>
                                    <input type="password" name="senha" id="password" class="form-control">
                                </div>
                                <div class="form-group">
                                    <input type="submit" name="submit" class="btn btn-info btn-md" value="Enviar">
                                </div>
                            </form>
                            <%
                                String email = request.getParameter("email");
                                String senha = request.getParameter("senha");
                                String se = "";
                                String em = "";
                                int i = 0;
                                String nomeUsuario = "";

                                try{

                                    st = new Conexao().conectar().createStatement();
                                    rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '"+ email +"' and senha = '" + senha + "'");
                                    while(rs.next()){
                                        em = rs.getString(3);
                                        se = rs.getString(4);
                                        nomeUsuario = rs.getString(2);
                                        rs.last();
                                        i = rs.getRow();
                                    }
                                }catch(Exception e){
                                    out.println(e);
                                }
                                if(email == null || senha == null){
                                    out.println("Os dados não foram preenchidos");
                                }else{
                                    session.setAttribute("nomeUsuario", nomeUsuario);
                                    response.sendRedirect("usuarios.jsp");
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
    </body>
</html>
