<%-- 
    Document   : usuarios
    Created on : 23/09/2020, 12:05:22
    Author     : Giovana
--%>

<%@page import="config.Conexao"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Usuarios</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <a class="navbar-brand" href="#">
                <%
                    String nome = (String) session.getAttribute("nomeUsuario");
                    out.println(nome);
                    
                    if (nome == null) {
                            response.sendRedirect("index.jsp");
                        }
                %></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                  <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>                  
                </li>
                <li class="nav-item">
                    <a class="nav-link text-danger btn btn-outline-danger" href="logout.jsp">Sair</a>
                </li>
                <!--
                <li class="nav-item">
                  <a class="nav-link" href="#">Link</a>
                </li>
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Dropdown
                  </a>
                  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Something else here</a>
                  </div>
                </li>
                <li class="nav-item">
                  <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
                </li>
                -->
              </ul>
                
              <form class="form-inline my-2 my-lg-0">
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">Cadastrar</button>
                &nbsp;&nbsp;
                <input class="form-control mr-sm-2" type="search" placeholder="Pesquisa" aria-label="Search">
                <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Buscar</button>
              </form>
            </div>
          </nav>
        
            <table class="table table-dark">
                <thead>
                  <tr>
                    <th scope="col">Id</th>
                    <th scope="col">Nome</th>
                    <th scope="col">Email</th>
                    <th scope="col">Senha</th>
                    <th scope="col">Nível</th>
                  </tr>
                </thead>
                <tbody>
                    
                  <%
                        Statement st = null;
                        ResultSet rs = null;
                        
                        String id_usuario = "";
                        String nome_usuario = "";
                        String email_usuario = "";
                        String senha_usuario = "";
                        String nivel_usuario = "";
                        
                        try{
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM usuarios");
                            while(rs.next()){
                    %>
                                <tr>
                                    <th scope="row"><%= rs.getString(1) %></th>
                                    <td><%= rs.getString(2) %></td>
                                    <td><%= rs.getString(3) %></td>
                                    <td><%= rs.getString(4) %></td>
                                    <td><%= rs.getString(5) %></td>
                                </tr>
                    
                    <%
                                
                            }
                        }catch(Exception e){
                            out.println(e);
                        }
                        
                    %>        
                </tbody>
              </table>
                
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </body> 
</html>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <form action="usuarios.jsp" method="post">
        <div class="modal-body">
          <div class="form-group">
              <label for="exampleInputPassword1">Nome:</label>
              <input type="text" class="form-control" name="nome" id="nome">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Email:</label>
              <input type="email" class="form-control" name="email" id="email">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">Senha:</label>
              <input type="password" class="form-control" name="senha" id="senha">
            </div>
            <label for="inputState">Nível:</label>
            <select id="inputState" name="nivel" class="form-control">
              <option value="Comum" selected>Comum</option>
              <option value="Admin">Admin</option>
            </select>

        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
          <button type="submit" name="btn-salvar" class="btn btn-primary">Cadastrar</button>
        </div>
    </form>
    </div>
  </div>
</div>

<%
    
    if (request.getParameter("btn-salvar") != null) {
        
            String nomeCadastro = request.getParameter("nome");
            String emailCadastro = request.getParameter("email");
            String senhaCadastro = request.getParameter("senha");
            String nivelCadastro = request.getParameter("nivel");
            
            try{
                
                st = new Conexao().conectar().createStatement();
                
                rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '"+ emailCadastro +"'");
                while(rs.next()){
                    rs.getRow();
                    if (rs.getRow() > 0) {
                            out.print("<script>alert('Este usuario ja foi cadastrado!')</script>");
                            return;
                        }
                }
                
                st.executeUpdate("INSERT INTO usuarios (nome, email, senha, nivel) VALUES ('"+nomeCadastro+"','"+emailCadastro+"','"+senhaCadastro+"','"+nivelCadastro+"')");
                response.sendRedirect("usuarios.jsp");
            }catch(Exception e){
                out.println(e);
            }
            
        }

%>
