# 🛍️ Sistema de Control de Pedidos - SUNMY

![Estado](https://img.shields.io/badge/Estado-Finalizado-success)
![Java](https://img.shields.io/badge/Java-Web-orange)
![Contexto](https://img.shields.io/badge/Contexto-Académico-blue)

Un sistema web integral para la gestión y control de pedidos diseñado para **SUNMY**, una tienda de ropa ficticia. Este proyecto académico fue desarrollado para aplicar conceptos avanzados de programación orientada a objetos, arquitectura web y despliegue en la nube, optimizando el flujo de ventas y la emisión de comprobantes.

---

## 🚀 Características Principales

* **Gestión de Pedidos:** Creación, lectura, actualización y eliminación (CRUD) de pedidos de prendas de vestir.
* **Carrito de Compras:** Interfaz dinámica para la selección de productos y cálculo de totales.
* **Facturación Electrónica:** Integración con una **API** de datos externos para la validación y gestión de datos (RUC/DNI) en el proceso de venta.
* **Diseño Responsivo:** Interfaz de usuario moderna y adaptable a múltiples dispositivos utilizando el framework CSS Bulma.
* **Despliegue en la Nube:** Arquitectura preparada para entornos Cloud, garantizando alta disponibilidad.

---

## 🛠️ Tecnologías Utilizadas

El proyecto está construido bajo una arquitectura Java Web clásica (MVC), utilizando las siguientes tecnologías:

### Frontend (Lenguajes de Marcado y Estilos)
* **HTML5:** Estructura semántica de la aplicación.
* **CSS3:** Estilos personalizados.
* **Bulma CSS:** Framework CSS ligero y moderno para el diseño de la interfaz.
* **JavaScript (JS):** Interactividad del lado del cliente y consumo asíncrono.

### Backend y Lógica de Negocio
* **Java:** Lenguaje de programación principal.
* **JSP (JavaServer Pages) & Servlets:** Tecnología web para la generación de páginas dinámicas y manejo de peticiones HTTP.
* **API SUNAT:** Consumo de servicios web para validación tributaria peruana.

### Persistencia de Datos
* **MySQL:** Motor de base de datos relacional para almacenar el inventario, usuarios y registros de pedidos.

### Infraestructura y Cloud Computing
* **Google Cloud / Microsoft Azure:** Plataformas en la nube para el alojamiento de la base de datos y/o despliegue de la aplicación.

### Control de Versiones
* **Git:** Control de versiones local.
* **GitHub:** Repositorio remoto y trabajo colaborativo.

---

## ⚙️ Instalación y Configuración Local

Si deseas ejecutar este proyecto en tu entorno local, sigue estos pasos:

### Prerrequisitos
* **JDK 8 o superior** instalado.
* Servidor de aplicaciones web (ej. **Apache Tomcat 9+**).
* **MySQL Server** en ejecución.
* Un IDE compatible con Java EE (Eclipse, NetBeans, o IntelliJ IDEA Ultimate).

### Pasos
1. **Clonar el repositorio:**
   ```bash
   git clone [https://github.com/TuUsuario/SUNMY-Control-Pedidos.git](https://github.com/TuUsuario/SUNMY-Control-Pedidos.git)
