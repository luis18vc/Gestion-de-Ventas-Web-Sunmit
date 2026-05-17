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
public class Producto {
    private String Id_Producto;
    private String Id_Articulo;
    private String Descripcion_Articulo;
    private String Descripcion;
    private double Costo;
    private double Precio;
    private double Cantidad;

    public Producto() {
        this.Id_Producto="";
        this.Id_Articulo="";
        this.Descripcion_Articulo="";
        this.Descripcion="";
        this.Costo=0;
        this.Precio=0;
        this.Cantidad=0;
    }

    public String getId_Producto() {
        return this.Id_Producto;
    }

    public void setId_Producto(String Id_Producto) {
        this.Id_Producto = Id_Producto;
    }

    public String getId_Articulo() {
        return Id_Articulo;
    }

    public void setId_Articulo(String Id_Articulo) {
        this.Id_Articulo = Id_Articulo;
    }

    public String getDescripcion_Articulo() {
        return this.Descripcion_Articulo;
    }

    public void setDescripcion_Articulo(String Descripcion_Articulo) {
        this.Descripcion_Articulo = Descripcion_Articulo;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public double getCosto() {
        return Costo;
    }

    public void setCosto(double Costo) {
        this.Costo = Costo;
    }

    public double getPrecio() {
        return Precio;
    }

    public void setPrecio(double Precio) {
        this.Precio = Precio;
    }

    public double getCantidad() {
        return Cantidad;
    }

    public void setCantidad(double Cantidad) {
        this.Cantidad = Cantidad;
    }
}
