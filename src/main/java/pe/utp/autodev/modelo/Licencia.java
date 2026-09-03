package pe.utp.autodev.modelo;

public class Licencia {

    private int idLicencia;
    private String razonSocial;
    private String ruc;
    private String producto;
    private String contacto;
    private String fechaInicio;
    private String fechaFin;
    private double montoContrato;
    private String estado;
    private int diasRestantes;

    public int getIdLicencia() { return idLicencia; }
    public void setIdLicencia(int idLicencia) { this.idLicencia = idLicencia; }

    public String getRazonSocial() { return razonSocial; }
    public void setRazonSocial(String razonSocial) { this.razonSocial = razonSocial; }

    public String getRuc() { return ruc; }
    public void setRuc(String ruc) { this.ruc = ruc; }

    public String getProducto() { return producto; }
    public void setProducto(String producto) { this.producto = producto; }

    public String getContacto() { return contacto; }
    public void setContacto(String contacto) { this.contacto = contacto; }

    public String getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(String fechaInicio) { this.fechaInicio = fechaInicio; }

    public String getFechaFin() { return fechaFin; }
    public void setFechaFin(String fechaFin) { this.fechaFin = fechaFin; }

    public double getMontoContrato() { return montoContrato; }
    public void setMontoContrato(double montoContrato) { this.montoContrato = montoContrato; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public int getDiasRestantes() { return diasRestantes; }
    public void setDiasRestantes(int diasRestantes) { this.diasRestantes = diasRestantes; }
}
