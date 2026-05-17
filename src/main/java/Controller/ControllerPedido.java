/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Connection.ConexionBD;
import Entity.Cliente;
import Entity.DetallePedido;
import Entity.Pedido;
import Entity.Producto;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author javie
 */
public class ControllerPedido extends HttpServlet {

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
            out.println("<title>Servlet ControllerPedido</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerPedido at " + request.getContextPath() + "</h1>");
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
        
        String Op =request.getParameter("Op");
        ArrayList<Pedido> Lista= new ArrayList<Pedido>();
        ArrayList<DetallePedido> ListaDet= new ArrayList<DetallePedido>();
        ArrayList<Cliente> ListaCliente= new ArrayList<Cliente>();
        ArrayList<Producto> ListaProducto= new ArrayList<Producto>();
        ConexionBD conBD = new ConexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        ResultSet rs;
        switch(Op){
            case "Listar":
                try {
                    String sql = "SELECT TP.Id_Pedido AS Id_Pedido, TC.Nombres "
                            + "AS Nombres, TC.Apellidos AS Apellidos, TP.Fecha "
                            + "AS Fecha, TP.SubTotal AS SubTotal, TP.TotalVenta "
                            + "AS TotalVenta FROM t_pedido AS TP INNER JOIN "
                            + "t_cliente AS TC ON TP.Id_Cliente = TC.Id_Cliente "
                            + "ORDER BY TP.Id_Pedido ASC";
                    ps = conn.prepareStatement(sql);
                    rs = ps.executeQuery();
                    
                    while (rs.next()) {
                        Pedido pedido = new Pedido();
                        pedido.setId_Pedido(rs.getString("Id_Pedido"));
                        pedido.setNombres(rs.getString("Nombres"));
                        pedido.setApellidos(rs.getString("Apellidos"));
                        pedido.setFecha(rs.getDate("Fecha"));
                        pedido.setSubTotal(rs.getDouble("SubTotal"));
                        pedido.setTotalVenta(rs.getDouble("TotalVenta"));
                        Lista.add(pedido);
                    }
                    
                    request.setAttribute("Lista", Lista);
                    request.getRequestDispatcher("FolderPedido/Pedidos.jsp").forward(request, response);
                } catch(SQLException ex) {
                    System.out.println("Error de SQL ... " + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;
            case "Consultar":
                try {
                    String Id=request.getParameter("Id");
                    String sqlCabecera = "SELECT TP.Id_Pedido AS Id_Pedido, "
                            + "TP.Fecha AS Fecha, TP.SubTotal AS SubTotal, "
                            + "TP.TotalVenta AS TotalVenta, TP.Id_Cliente AS "
                            + "Id_Cliente, TC.Nombres AS Nombres, TC.Apellidos "
                            + "AS Apellidos, TC.Direccion AS Direccion FROM "
                            + "t_pedido AS TP INNER JOIN t_cliente  AS TC ON "
                            + "TP.Id_Cliente = TC.Id_Cliente WHERE TP.Id_Pedido = ?";
                    String sqlDetalle = "SELECT TDP.Id_Prod AS Id_Prod, TPD.Descripcion "
                            + "AS Descripcion, TDP.precio AS Precio, TDP.cantidad "
                            + "AS Cantidad, ((TDP.cantidad * TDP.precio) * 0.18) "
                            + "AS IGV, TDP.TotalDeta AS SubTotal FROM t_detalle_pedido "
                            + "AS TDP INNER JOIN t_pedido AS TP ON TDP.Id_Pedido = "
                            + "TP.Id_Pedido INNER JOIN t_producto AS TPD ON TDP.Id_Prod = "
                            + "TPD.Id_Prod WHERE TDP.Id_Pedido = ?";
                    
                    ps = conn.prepareStatement(sqlCabecera);
                    ps.setString(1, Id);
                    rs = ps.executeQuery();
                    Pedido pedido = new Pedido();
                    
                    while (rs.next()) {
                        pedido.setId_Pedido(rs.getString("Id_Pedido"));
                        pedido.setId_Cliente(rs.getString("Id_Cliente"));
                        pedido.setNombres(rs.getString("Nombres"));
                        pedido.setApellidos(rs.getString("Apellidos"));
                        pedido.setDireccion(rs.getString("Direccion"));
                        pedido.setFecha(rs.getDate("Fecha"));
                        pedido.setSubTotal(rs.getDouble("SubTotal"));
                        pedido.setTotalVenta(rs.getDouble("TotalVenta"));
                        Lista.add(pedido);
                    }
                    
                    ps = conn.prepareStatement(sqlDetalle);
                    ps.setString(1, Id);
                    rs = ps.executeQuery();
                    
                    while (rs.next()) {
                        DetallePedido detallePedido = new DetallePedido();
                        detallePedido.setId_Prod(rs.getString("Id_Prod"));
                        detallePedido.setDescripcion(rs.getString("Descripcion"));
                        detallePedido.setPrecio(rs.getDouble("Precio"));
                        detallePedido.setCantidad(rs.getInt("Cantidad"));
                        detallePedido.setIGV(rs.getDouble("IGV"));
                        detallePedido.setTotalDeta(rs.getDouble("SubTotal"));
                        ListaDet.add(detallePedido);
                    }
                    
                    request.setAttribute("Lista", Lista);
                    request.setAttribute("ListaDet", ListaDet);
                    request.getRequestDispatcher("FolderPedido/consultarPedido.jsp").forward(request, response);
                } catch (SQLException ex) {
                    System.out.println("Error de SQL ... " + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;                   
            case "Eliminar":
                try {
                    String Id=request.getParameter("Id");
                    String sql = "DELETE FROM t_pedido WHERE Id_Pedido = ?";
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, Id);
                    ps.executeUpdate();
                    response.sendRedirect("ControllerPedido?Op=Listar");
                } catch(SQLException ex) {
                    System.out.println("Error de SQL ... " + ex.getMessage());
                } finally {
                    conBD.Discconet();
                }
                break;
            case "Registrar":
                try{
                    String sql="SELECT * FROM t_cliente ORDER BY Id_Cliente ASC";
                    ps= conn.prepareStatement(sql);
                    rs= ps.executeQuery();
                    while(rs.next()){
                        Cliente client=new Cliente();
                        client.setIdCliente(rs.getString("Id_Cliente"));
                        client.setApellidos(rs.getString("Apellidos"));
                        client.setNombres(rs.getString("Nombres"));
                        client.setDNI(rs.getString("DNI"));
                        client.setDireccion(rs.getString("Direccion"));
                        client.setTelefono(rs.getString("Telefono"));
                        client.setMovil(rs.getString("Movil"));
                        ListaCliente.add(client);
                    }
                    
                    String sql1="SELECT TP.Id_Prod AS Id_Prod, TAC.Descripcion "
                            + "AS Articulo, TP.Descripcion, TP.costo, TP.precio, "
                            + "TP.cantidad FROM t_producto AS TP INNER JOIN "
                            + "t_articulo AS TAC ON TP.Id_Articulo = TAC.Id_Aritculo";
                    ps= conn.prepareStatement(sql1);
                    rs= ps.executeQuery();
                    while(rs.next()){
                        Producto producto=new Producto();
                        producto.setId_Producto(rs.getString("Id_Prod"));
                        producto.setDescripcion_Articulo(rs.getString("Articulo"));
                        producto.setDescripcion(rs.getString("Descripcion"));
                        producto.setCosto(rs.getDouble("costo"));
                        producto.setPrecio(rs.getDouble("precio"));
                        producto.setCantidad(rs.getDouble("cantidad"));
                        ListaProducto.add(producto);
                    }
                    
                    String sql2="select max(Id_Pedido) AS Id_Pedido from t_pedido";
                    String Id_Pedido="";
                    ps= conn.prepareStatement(sql2);
                    rs= ps.executeQuery();
                    while(rs.next()){
                        Id_Pedido=rs.getString("Id_Pedido");
                    }
                    Id_Pedido=newCod(Id_Pedido);
            
                    request.setAttribute("NrPedido", Id_Pedido);
                    request.setAttribute("ListaProducto", ListaProducto);
                    request.setAttribute("ListaCliente", ListaCliente);
                    request.getRequestDispatcher("FolderPedido/registrarPedido.jsp").forward(request, response);
                }catch(SQLException ex){
                    System.out.println("Error de SQL..."+ex.getMessage());
                } finally{
                    conBD.Discconet();
                }
                break;
            case "PDF":
                try {
                    String Id=request.getParameter("Id");
                    String sqlCabecera = "SELECT TP.Id_Pedido AS Id_Pedido, "
                            + "TP.Fecha AS Fecha, TP.SubTotal AS SubTotal, "
                            + "TP.TotalVenta AS TotalVenta, TP.Id_Cliente AS "
                            + "Id_Cliente, TC.Nombres AS Nombres, TC.Apellidos "
                            + "AS Apellidos, TC.Direccion AS Direccion FROM "
                            + "t_pedido AS TP INNER JOIN t_cliente  AS TC ON "
                            + "TP.Id_Cliente = TC.Id_Cliente WHERE TP.Id_Pedido = ?";
                    String sqlDetalle = "SELECT TDP.Id_Prod AS Id_Prod, TPD.Descripcion "
                            + "AS Descripcion, TDP.precio AS Precio, TDP.cantidad "
                            + "AS Cantidad, ((TDP.cantidad * TDP.precio) * 0.18) "
                            + "AS IGV, TDP.TotalDeta AS SubTotal FROM t_detalle_pedido "
                            + "AS TDP INNER JOIN t_pedido AS TP ON TDP.Id_Pedido = "
                            + "TP.Id_Pedido INNER JOIN t_producto AS TPD ON TDP.Id_Prod = "
                            + "TPD.Id_Prod WHERE TDP.Id_Pedido = ?";
                    
                    ps = conn.prepareStatement(sqlCabecera);
                    ps.setString(1, Id);
                    rs = ps.executeQuery();
                    Pedido pedido = new Pedido();
                    
                    while (rs.next()) {
                        pedido.setId_Pedido(rs.getString("Id_Pedido"));
                        pedido.setId_Cliente(rs.getString("Id_Cliente"));
                        pedido.setNombres(rs.getString("Nombres"));
                        pedido.setApellidos(rs.getString("Apellidos"));
                        pedido.setDireccion(rs.getString("Direccion"));
                        pedido.setFecha(rs.getDate("Fecha"));
                        pedido.setSubTotal(rs.getDouble("SubTotal"));
                        pedido.setTotalVenta(rs.getDouble("TotalVenta"));
                        Lista.add(pedido);
                    }
                    
                    ps = conn.prepareStatement(sqlDetalle);
                    ps.setString(1, Id);
                    rs = ps.executeQuery();
                    
                    while (rs.next()) {
                        DetallePedido detallePedido = new DetallePedido();
                        detallePedido.setId_Prod(rs.getString("Id_Prod"));
                        detallePedido.setDescripcion(rs.getString("Descripcion"));
                        detallePedido.setPrecio(rs.getDouble("Precio"));
                        detallePedido.setCantidad(rs.getInt("Cantidad"));
                        detallePedido.setIGV(rs.getDouble("IGV"));
                        detallePedido.setTotalDeta(rs.getDouble("SubTotal"));
                        ListaDet.add(detallePedido);
                    }
                    
                    response.setContentType("application/pdf");
                    response.setHeader("Content-Disposition", "inline; filename=pedido_"+ Id +".pdf");
                    
                    Document documento = new Document();
                    PdfWriter.getInstance(documento, response.getOutputStream());
                    documento.open();
                    
                    // Estilos
                    // cabecera
                    Font fontTitulo = new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, BaseColor.BLUE);
                    Font fontSubtitulo = new Font(Font.FontFamily.HELVETICA, 14, Font.ITALIC, BaseColor.GRAY);
                    Font fontNormal = new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.NORMAL, BaseColor.BLACK);
                    // linea divisora
                    LineSeparator separator = new LineSeparator();
                    separator.setLineColor(BaseColor.GRAY);
                    separator.setPercentage(80);
                    separator.setAlignment(Element.ALIGN_CENTER);
                    
                    // Cabecera
                    documento.add(new Paragraph("Pedido " + Id, fontTitulo));
                    documento.add(new Paragraph("\n"));
                    documento.add(new Chunk(separator));
                    documento.add(new Paragraph("\n"));
                    documento.add(new Paragraph("Detalles de Cliente", fontSubtitulo));
                    documento.add(new Paragraph("ID: " + pedido.getId_Cliente(), fontNormal));
                    documento.add(new Paragraph("Nombres: " + pedido.getNombres(), fontNormal));
                    documento.add(new Paragraph("Apellidos: " + pedido.getApellidos(), fontNormal));
                    documento.add(new Paragraph("\n"));
                    documento.add(new Chunk(separator));
                    documento.add(new Paragraph("\n"));
                    documento.add(new Paragraph("Fecha: " + pedido.getFecha(), fontNormal));
                    documento.add(new Paragraph("\n"));
                    documento.add(new Chunk(separator));
                    documento.add(new Paragraph("\n"));
                    
                    // Tabla para los Detalles
                    documento.add(new Paragraph("Detalles", fontSubtitulo));
                    documento.add(new Paragraph("\n"));
                    PdfPTable tabla = new PdfPTable(6);
                    tabla.setWidthPercentage(100);
                    tabla.addCell("ID Producto");
                    tabla.addCell("Descripción");
                    tabla.addCell("Precio");
                    tabla.addCell("Cantidad");
                    tabla.addCell("IGV");
                    tabla.addCell("Subtotal");
                    
                    // Detalle
                    for (DetallePedido item: ListaDet) {
                        tabla.addCell(item.getId_Prod());
                        tabla.addCell(item.getDescripcion());
                        tabla.addCell(String.format("S/ %.2f", item.getPrecio()));
                        tabla.addCell(String.valueOf(item.getCantidad()));
                        tabla.addCell(String.format("S/ %.2f", item.getIGV()));
                        tabla.addCell(String.format("S/ %.2f", item.getTotalDeta()));
                    }
                    documento.add(tabla);
                    
                    // Pie de Pdf
                    documento.add(new Chunk(separator));
                    documento.add(new Paragraph("Subtotal: S/ " + pedido.getSubTotal()));
                    documento.add(new Paragraph("Total: S/ " + pedido.getTotalVenta()));
                    documento.add(new Paragraph("\nGracias por su compra."));
                    
                    documento.close();
                } catch(SQLException ex) {
                    System.out.println("Error de SQL... " + ex.getMessage());
                } catch (DocumentException ex) {
                    System.out.println("Error de PDF... " + ex.getMessage());
                } catch(IOException ex) {
                    System.out.println("Error de PDF... " + ex.getMessage());
                } finally {
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
        
        String codigoCliente = request.getParameter("idCliente");
        String fecha = request.getParameter("txtFecha");
        String subTotal = request.getParameter("subtotal");
        String totalVenta = request.getParameter("totalVenta");
        
        String[] idProductos = new String[10];
        String[] cantidades = new String[10];
        String[] precios = new String[10];
        String[] totalDetalles = new String[10];
        
        for (int i = 0; i < 10; i++) {
            idProductos[i] = request.getParameter("codigo_" + i) != null ? request.getParameter("codigo_" + i) : "";
            cantidades[i] = request.getParameter("cantidad_" + i);
            precios[i] = request.getParameter("precio_" + i);
            totalDetalles[i] = request.getParameter("total_" + i) != null && !request.getParameter("total_" + i).isEmpty() 
                   ? request.getParameter("total_" + i) 
                   : "0";
        }
        
        Pedido pedido = new Pedido();
        pedido.setId_Cliente(codigoCliente);
        pedido.setFecha(Date.valueOf(fecha));
        pedido.setSubTotal(Double.parseDouble(subTotal));
        pedido.setTotalVenta(Double.parseDouble(totalVenta));
        
        ArrayList<DetallePedido> detallePedidos = new ArrayList();
        for (int i=0; i <10 ; i++) {
            DetallePedido detallePedido = new DetallePedido();
            detallePedido.setId_Prod(idProductos[i]);
            detallePedido.setCantidad(Double.parseDouble(cantidades[i]));
            detallePedido.setPrecio(Double.parseDouble(precios[i]));
            detallePedido.setTotalDeta(Double.parseDouble(totalDetalles[i]));
            detallePedidos.add(detallePedido);
        }
        
        ConexionBD conBD = new ConexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        PreparedStatement psD;
        ResultSet rs;
        
        try {
            String sql_new="select max(Id_Pedido) AS Id_Pedido from t_pedido";
            String sql="insert into t_pedido(Id_Pedido, Id_Cliente, Fecha, "
                    + "SubTotal, TotalVenta) values(?, ?, ?, ?, ?)";
            
            String Id_Pedido="";
            ps= conn.prepareStatement(sql_new);
            rs= ps.executeQuery();
            while(rs.next()){
                Id_Pedido=rs.getString("Id_Pedido");
            }
            Id_Pedido=newCod(Id_Pedido);
            
            ps= conn.prepareStatement(sql);
            ps.setString(1, Id_Pedido);
            ps.setString(2, pedido.getId_Cliente());
            ps.setDate(3, pedido.getFecha());
            ps.setDouble(4, pedido.getSubTotal());
            ps.setDouble(5, pedido.getTotalVenta());
            ps.executeUpdate(); 
            
            String pedidoS = Id_Pedido;
            String sqlD="insert into t_detalle_pedido(Id_Pedido, Id_Prod, "
                    + "cantidad, precio, TotalDeta) values (?, ?, ?, ?, ?)";
            ps = conn.prepareStatement(sqlD);
            for (int i=0; i < 10; i++) {
                ps.setString(1, pedidoS);
                ps.setString(2, detallePedidos.get(i).getId_Prod());
                ps.setDouble(3, detallePedidos.get(i).getCantidad());
                ps.setDouble(4, detallePedidos.get(i).getPrecio());
                ps.setDouble(5, detallePedidos.get(i).getTotalDeta());
                ps.executeUpdate();
            }
        } catch(SQLException ex) {
            System.out.println("Error de SQL..."+ex.getMessage());
        } finally {
            conBD.Discconet();
        }
        
        response.sendRedirect("ControllerPedido?Op=Listar");
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
            pCodigo = "PD0000";
        }
        int Numero;
        Numero=Integer.parseInt(pCodigo.substring(2));
        Numero=Numero+1;
        pCodigo=String.valueOf(Numero);
        while (pCodigo.length()<4){
            pCodigo='0'+ pCodigo;
        }
        pCodigo="PD"+pCodigo;        
        return (pCodigo);
    }
}
