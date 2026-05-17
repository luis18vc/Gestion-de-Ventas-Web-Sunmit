/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Connection.ConexionBD;
import Entity.Articulo;
import Entity.Usuarios;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Leonardo
 */
public class ControllerArticulo extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ControllerArticulo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerArticulo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        //processRequest(request, response);
        
        HttpSession session=request.getSession();
        Usuarios user=(Usuarios)session.getAttribute("user");
        if(user==null){
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
        String Op =request.getParameter("Op");
        ArrayList<Articulo> Lista= new ArrayList<Articulo>();
        ConexionBD conBD = new ConexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        ResultSet rs;
        switch(Op){
            case "Listar":
                try{
                    String sql="SELECT * FROM t_articulo";
                    ps= conn.prepareStatement(sql);
                    rs= ps.executeQuery();
                    while(rs.next()){
                        Articulo articulo=new Articulo();
                        articulo.setId_Articulo(rs.getString("Id_Aritculo"));
                        articulo.setDescripcion(rs.getString("Descripcion"));
                        articulo.setEstado(rs.getBoolean("Estado"));
                        Lista.add(articulo);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("FolderArticulo/Articulo.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }
                break;
            case "Consultar":
                try{
                    String Id=request.getParameter("Id");
                    String sql="select * from t_articulo where Id_Aritculo=?";
                    ps= conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    rs= ps.executeQuery();
                    Articulo articulo=new Articulo();
                    while(rs.next()){
                        articulo.setId_Articulo(rs.getString("Id_Aritculo"));
                        articulo.setDescripcion(rs.getString("Descripcion"));
                        articulo.setEstado(rs.getBoolean("Estado"));
                        Lista.add(articulo);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("FolderArticulo/consultarArticulo.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }                
                break;    
            case "Modificar":
                try{
                    String Id=request.getParameter("Id");
                    String sql="select * from t_articulo where Id_Aritculo=?";
                    ps= conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    rs= ps.executeQuery();
                    Articulo articulo=new Articulo();
                    while(rs.next()){
                        articulo.setId_Articulo(rs.getString("Id_Aritculo"));
                        articulo.setDescripcion(rs.getString("Descripcion"));
                        articulo.setEstado(rs.getBoolean("Estado"));
                        Lista.add(articulo);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("FolderArticulo/editarArticulo.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }                 
                
                break;
            case "Eliminar":
                try{
                    String Id=request.getParameter("Id");
                    String sql="delete from t_articulo where Id_Aritculo=?";
                    ps= conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    ps.executeUpdate();
                    response.sendRedirect("ControllerArticulo?Op=Listar");
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }                          
                break;
            case "Nuevo":
                request.getRequestDispatcher("FolderArticulo/nuevoArticulo.jsp").forward(request, response);
                break;
        }
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
        //processRequest(request, response);
        
        String Id =request.getParameter("txtId");       
        String Descripcion=request.getParameter("txtNombre"); 
        String Estado=request.getParameter("selectEstado");
        Articulo articulo=new Articulo();
        
        articulo.setId_Articulo(Id);
        articulo.setDescripcion(Descripcion);
        articulo.setEstado(Boolean.parseBoolean(Estado));
        
        ConexionBD conBD = new ConexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        ResultSet rs;        
        if(Id.isEmpty()){
            String sql_new="select max(Id_Aritculo) AS Id_Aritculo from t_articulo";
            String sql="insert into t_articulo(Id_Aritculo, Descripcion, Estado) values(?, ?, ?)";

            try{
                /*Algoritmo para autogeneral el código*/
                //String Id_Aritculo="A00020";
                /*Algoritmo para autogenerar el código*/
                String Id_Aritculo="";
                ps= conn.prepareStatement(sql_new);
                rs= ps.executeQuery();
                while(rs.next()){
                    Id_Aritculo=rs.getString("Id_Aritculo");
                }
                Id_Aritculo=newCod(Id_Aritculo);
                ps= conn.prepareStatement(sql);
                ps.setString(1, Id_Aritculo);
                ps.setString(2, articulo.getDescripcion());
                ps.setBoolean(3, articulo.getEstado());
                
                ps.executeUpdate(); 
            }catch(SQLException ex){
                System.out.println("Error actualizando tabla..."+ex.getMessage());
            } finally{
                conBD.Discconet();
            }               
        }else{
            String sql="update t_articulo set Descripcion=?, Estado=? where Id_Aritculo=?";

            try{
                ps= conn.prepareStatement(sql);
                ps.setString(1, articulo.getDescripcion());
                ps.setBoolean(2, articulo.getEstado());
                ps.setString(3, articulo.getId_Articulo());
                ps.executeUpdate(); 
            }catch(SQLException ex){
                System.out.println("Error actualizando tabla..."+ex.getMessage());
            } finally{
                conBD.Discconet();
            }               
        }
        
        response.sendRedirect("ControllerArticulo?Op=Listar");
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

    private String newCod(String pCodigo) {
        // Note that the injected javax.xml.ws.Service reference as well as port objects are not thread safe.
        // If the calling of port operations may lead to race condition some synchronization is required.
        //com.service.util.WebServiceUtil port = service.getWebServiceUtilPort();
        if (pCodigo == null) {
            pCodigo = "A00000";
        }
        int Numero;
        Numero=Integer.parseInt(pCodigo.substring(2));
        Numero=Numero+1;
        pCodigo=String.valueOf(Numero);
        while (pCodigo.length()<5){
            pCodigo='0'+ pCodigo;
        }
        pCodigo='A'+pCodigo;        
        return (pCodigo);
    }
}
