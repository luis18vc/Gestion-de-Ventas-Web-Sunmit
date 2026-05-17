/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Connection.ConexionBD;
import Entity.Usuarios;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Leonardo
 */
public class ControllerRegister extends HttpServlet {

    private static final String HASH_ALGORITHM = "SHA-256";
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
            out.println("<title>Servlet ControllerRegister</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ControllerRegister at " + request.getContextPath() + "</h1>");
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
        
        request.getRequestDispatcher("registro.jsp").forward(request, response);
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
        
        String user, pass;
        
        user = request.getParameter("txtUsuario");
        pass= request.getParameter("txtClave");
        pass = hashPassword(pass);
        
        ConexionBD conBD = new ConexionBD();
        Connection conn = conBD.Connected();
        PreparedStatement ps;
        
        if ((user == null || user.isEmpty()) || (pass == null || pass.isEmpty())) {
            request.setAttribute("errorMessage", "Campos no Validos");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        } else {
            try {
                String sql="insert into t_usuario (IdUsuario, Passwd) values (?, ?)";
                ps= conn.prepareStatement(sql);
                ps.setString(1, user);
                ps.setString(2, pass);
                
                if (ps.executeUpdate() > 0) {
                    request.setAttribute("exitoMessage", "Usuario registrado exitosamente");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Fallo en el registro");
                }
                
            } catch(SQLException ex) {
                System.out.println("Error de SQL..."+ex.getMessage());
            } finally {
                conBD.Discconet();
            }
        }
        
        response.sendRedirect("ControllerLogin");
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

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] hash = digest.digest(password.getBytes());

            // Convertir el hash a un string en Base64 para una mejor legibilidad
            return Base64.getEncoder().encodeToString(hash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error al crear el hash de la contraseña", e);
        }
    }
}
