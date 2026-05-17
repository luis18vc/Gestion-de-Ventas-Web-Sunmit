/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Entity;

/**
 *
 * @author javie
 */
public class Cliente {
    private String Id_Cliente;
    private String Apellidos;
    private String Nombres;
    private String Direccion;
    private String DNI;
    private String Telefono;
    private String Movil;

    public Cliente() {
        this.Id_Cliente="";
        this.Apellidos="";
        this.Nombres="";
        this.Direccion="";
        this.DNI="";
        this.Telefono="";
        this.Movil="";
    }

    public String getIdCliente() {
        return Id_Cliente;
    }

    public void setIdCliente(String Id_Cliente) {
        this.Id_Cliente = Id_Cliente;
    }

    public String getApellidos() {
        return Apellidos;
    }

    public void setApellidos(String Apellidos) {
        this.Apellidos = Apellidos;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String Nombres) {
        this.Nombres = Nombres;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getDNI() {
        return DNI;
    }

    public void setDNI(String DNI) {
        this.DNI = DNI;
    }

    public String getTelefono() {
        return Telefono;
    }

    public void setTelefono(String Telefono) {
        this.Telefono = Telefono;
    }

    public String getMovil() {
        return Movil;
    }

    public void setMovil(String Movil) {
        this.Movil = Movil;
    }
}
