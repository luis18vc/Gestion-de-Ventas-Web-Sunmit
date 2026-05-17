/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author Leonardo
 */
public class Articulo {
    private String Id_Articulo;
    private String Descripcion;
    private boolean Estado;
    
    public Articulo() {
        this.Id_Articulo="";
        this.Descripcion="";
        this.Estado=true;
    }

    public String getId_Articulo() {
        return this.Id_Articulo;
    }

    public void setId_Articulo(String Id_Articulo) {
        this.Id_Articulo = Id_Articulo;
    }

    public String getDescripcion() {
        return this.Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public boolean getEstado() {
        return this.Estado;
    }

    public void setEstado(boolean Estado) {
        this.Estado = Estado;
    }
}
