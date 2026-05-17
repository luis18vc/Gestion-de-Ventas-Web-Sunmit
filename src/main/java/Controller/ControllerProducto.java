/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Connection.ConexionBD;
import Entity.Producto;
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
public class ControllerProducto extends HttpServlet {

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
            out.println("<title>Servlet ControllerProducto</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerProducto at " + request.getContextPath() + "</h1>");
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
        ArrayList<Producto> Lista= new ArrayList<Producto>();
        ArrayList<Articulo> ListaArticulo= new ArrayList<Articulo>();
        ConexionBD conBD = new ConexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        ResultSet rs;
        switch(Op){
            case "Listar":
                try{
                    String sql="SELECT TP.Id_Prod AS Id_Prod, TAC.Descripcion "
                            + "AS Articulo, TP.Descripcion, TP.costo, TP.precio, "
                            + "TP.cantidad FROM t_producto AS TP INNER JOIN "
                            + "t_articulo AS TAC ON TP.Id_Articulo = TAC.Id_Aritculo";
                    ps= conn.prepareStatement(sql);
                    rs= ps.executeQuery();
                    while(rs.next()){
                        Producto producto=new Producto();
                        producto.setId_Producto(rs.getString("Id_Prod"));
                        producto.setDescripcion_Articulo(rs.getString("Articulo"));
                        producto.setDescripcion(rs.getString("Descripcion"));
                        producto.setCosto(rs.getDouble("costo"));
                        producto.setPrecio(rs.getDouble("precio"));
                        producto.setCantidad(rs.getDouble("cantidad"));
                        Lista.add(producto);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("FolderProducto/Productos.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }
                break;
            case "Consultar":
                try{
                    String Id=request.getParameter("Id");
                    String sql="SELECT TP.Id_Prod AS Id_Prod, TAC.Descripcion "
                            + "AS Articulo, TP.Descripcion, TP.costo, TP.precio, "
                            + "TP.cantidad FROM t_producto AS TP INNER JOIN "
                            + "t_articulo AS TAC ON TP.Id_Articulo = TAC.Id_Aritculo WHERE TP.Id_Prod = ?";
                    ps= conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    rs= ps.executeQuery();
                    Producto producto=new Producto();
                    while(rs.next()){
                        producto.setId_Producto(rs.getString("Id_Prod"));
                        producto.setDescripcion_Articulo(rs.getString("Articulo"));
                        producto.setDescripcion(rs.getString("Descripcion"));
                        producto.setCosto(rs.getDouble("costo"));
                        producto.setPrecio(rs.getDouble("precio"));
                        producto.setCantidad(rs.getDouble("cantidad"));
                        Lista.add(producto);
                    }
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("FolderProducto/consultarProducto.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }                
                break;    
            case "Modificar":
                try{
                    // Encontrar Producto
                    String Id=request.getParameter("Id");
                    String sql="select * from t_producto where Id_Prod=?";
                    ps= conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    rs= ps.executeQuery();
                    Producto producto=new Producto();
                    while(rs.next()){
                        producto.setId_Producto(rs.getString("Id_Prod"));
                        producto.setId_Articulo(rs.getString("Id_Articulo"));
                        producto.setDescripcion(rs.getString("Descripcion"));
                        producto.setCosto(rs.getDouble("costo"));
                        producto.setPrecio(rs.getDouble("precio"));
                        producto.setCantidad(rs.getDouble("cantidad"));
                        Lista.add(producto);
                    }
                    // Traer Articulos
                    String sqlA="SELECT * FROM t_articulo";
                    ps= conn.prepareStatement(sqlA);
                    rs= ps.executeQuery();
                    while(rs.next()){
                        Articulo articulo=new Articulo();
                        articulo.setId_Articulo(rs.getString("Id_Aritculo"));
                        articulo.setDescripcion(rs.getString("Descripcion"));
                        articulo.setEstado(rs.getBoolean("Estado"));
                        ListaArticulo.add(articulo);
                    }
                    
                    request.setAttribute("ListaA", ListaArticulo);
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("FolderProducto/editarProducto.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }                 
                
                break;
            case "Eliminar":
                try{
                    String Id=request.getParameter("Id");
                    String sql="delete from t_producto where Id_Prod=?";
                    ps= conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    ps.executeUpdate();
                    response.sendRedirect("ControllerProducto?Op=Listar");
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }                          
                break;
            case "Nuevo":
                try{
                    String sql="SELECT * FROM t_articulo WHERE Estado = 1";
                    ps= conn.prepareStatement(sql);
                    rs= ps.executeQuery();
                    while(rs.next()){
                        Articulo articulo=new Articulo();
                        articulo.setId_Articulo(rs.getString("Id_Aritculo"));
                        articulo.setDescripcion(rs.getString("Descripcion"));
                        articulo.setEstado(rs.getBoolean("Estado"));
                        ListaArticulo.add(articulo);
                    }
                    request.setAttribute("Lista", ListaArticulo);
                    request.getRequestDispatcher("FolderProducto/nuevoProducto.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }
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
        
        String Id =request.getParameter("Id");       
        String Id_Arti=request.getParameter("Id_Arti"); 
        String Descripcion=request.getParameter("descripcion");
        String Costo =request.getParameter("costo");       
        String Precio=request.getParameter("precio"); 
        String Cantidad=request.getParameter("cantidad");
        Producto producto=new Producto();
        
        producto.setId_Producto(Id);
        producto.setId_Articulo(Id_Arti);
        producto.setDescripcion(Descripcion);
        producto.setCosto(Double.parseDouble(Costo));
        producto.setPrecio(Double.parseDouble(Precio));
        producto.setCantidad(Double.parseDouble(Cantidad));
        
        ConexionBD conBD = new ConexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        ResultSet rs;        
        if(Id.isEmpty()){
            String sql_new="select max(Id_Prod) AS Id_Prod from t_producto";
            String sql="insert into t_producto(Id_Prod, Id_Articulo, Descripcion, costo, precio, cantidad) values(?, ?, ?, ?, ?, ?)";

            try{
                /*Algoritmo para autogeneral el código*/
                //String Id_Producto="P00020";
                /*Algoritmo para autogenerar el código*/
                String ID_Prod="";
                ps= conn.prepareStatement(sql_new);
                rs= ps.executeQuery();
                while(rs.next()){
                    ID_Prod=rs.getString("Id_Prod");
                }
                ID_Prod=newCod(ID_Prod);
                ps= conn.prepareStatement(sql);
                ps.setString(1, ID_Prod);
                ps.setString(2, producto.getId_Articulo());
                ps.setString(3, producto.getDescripcion());
                ps.setDouble(4, producto.getCosto());
                ps.setDouble(5, producto.getPrecio());
                ps.setDouble(6, producto.getCantidad());
                
                ps.executeUpdate(); 
            }catch(SQLException ex){
                System.out.println("Error actualizando tabla..."+ex.getMessage());
            } finally{
                conBD.Discconet();
            }               
        }else{
            String sql="update t_producto set Id_Articulo=?, Descripcion=?, costo=?, precio=?, cantidad=? where Id_Prod=?";

            try{
                ps= conn.prepareStatement(sql);
                ps.setString(1, producto.getId_Articulo());
                ps.setString(2, producto.getDescripcion());
                ps.setDouble(3, producto.getCosto());
                ps.setDouble(4, producto.getPrecio());
                ps.setDouble(5, producto.getCantidad());
                ps.setString(6, producto.getId_Producto());
                ps.executeUpdate(); 
            }catch(SQLException ex){
                System.out.println("Error actualizando tabla..."+ex.getMessage());
            } finally{
                conBD.Discconet();
            }               
        }
        
        response.sendRedirect("ControllerProducto?Op=Listar");
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
            pCodigo = "P00000";
        }
        int Numero;
        Numero=Integer.parseInt(pCodigo.substring(2));
        Numero=Numero+1;
        pCodigo=String.valueOf(Numero);
        while (pCodigo.length()<5){
            pCodigo='0'+ pCodigo;
        }
        pCodigo='P'+pCodigo;        
        return (pCodigo);
    }
}
