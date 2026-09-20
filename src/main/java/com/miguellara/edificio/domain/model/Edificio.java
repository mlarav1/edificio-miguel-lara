package com.miguellara.edificio.domain.model;

import java.math.BigDecimal;

/**
 * Entidad Edificio (ejercicio 13). "id" es una clave tecnica autoincremental
 * que no forma parte de los atributos pedidos por el ejercicio pero es
 * necesaria para identificar el registro en la base de datos.
 */
public class Edificio {

    private Integer id;
    private String nombre;
    private BigDecimal metrosCuadrados;
    private BigDecimal altura;
    private Integer numPisos;
    private Integer numApartamentos;
    private Integer numOficinas;
    private String nombreParqueadero;
    private Integer numPiscinas;
    private String pais;
    private String departamento;
    private String ciudad;
    private boolean tieneAscensor;
    private BigDecimal valorAdministracion;
    private boolean tieneZonaSocial;

    public Edificio() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public BigDecimal getMetrosCuadrados() {
        return metrosCuadrados;
    }

    public void setMetrosCuadrados(BigDecimal metrosCuadrados) {
        this.metrosCuadrados = metrosCuadrados;
    }

    public BigDecimal getAltura() {
        return altura;
    }

    public void setAltura(BigDecimal altura) {
        this.altura = altura;
    }

    public Integer getNumPisos() {
        return numPisos;
    }

    public void setNumPisos(Integer numPisos) {
        this.numPisos = numPisos;
    }

    public Integer getNumApartamentos() {
        return numApartamentos;
    }

    public void setNumApartamentos(Integer numApartamentos) {
        this.numApartamentos = numApartamentos;
    }

    public Integer getNumOficinas() {
        return numOficinas;
    }

    public void setNumOficinas(Integer numOficinas) {
        this.numOficinas = numOficinas;
    }

    public String getNombreParqueadero() {
        return nombreParqueadero;
    }

    public void setNombreParqueadero(String nombreParqueadero) {
        this.nombreParqueadero = nombreParqueadero;
    }

    public Integer getNumPiscinas() {
        return numPiscinas;
    }

    public void setNumPiscinas(Integer numPiscinas) {
        this.numPiscinas = numPiscinas;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getDepartamento() {
        return departamento;
    }

    public void setDepartamento(String departamento) {
        this.departamento = departamento;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public boolean isTieneAscensor() {
        return tieneAscensor;
    }

    public void setTieneAscensor(boolean tieneAscensor) {
        this.tieneAscensor = tieneAscensor;
    }

    public BigDecimal getValorAdministracion() {
        return valorAdministracion;
    }

    public void setValorAdministracion(BigDecimal valorAdministracion) {
        this.valorAdministracion = valorAdministracion;
    }

    public boolean isTieneZonaSocial() {
        return tieneZonaSocial;
    }

    public void setTieneZonaSocial(boolean tieneZonaSocial) {
        this.tieneZonaSocial = tieneZonaSocial;
    }
}
