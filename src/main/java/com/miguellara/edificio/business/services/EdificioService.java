package com.miguellara.edificio.business.services;

import com.miguellara.edificio.business.exceptions.PersistenciaException;
import com.miguellara.edificio.business.exceptions.ValidacionException;
import com.miguellara.edificio.domain.model.Edificio;
import com.miguellara.edificio.infrastructure.persistence.EdificioDAO;

import java.math.BigDecimal;
import java.util.List;

/** Reglas de negocio de Edificio: validacion y delegacion al DAO. */
public class EdificioService {

    private final EdificioDAO edificioDAO = new EdificioDAO();

    public void crear(Edificio edificio) throws ValidacionException, PersistenciaException {
        validar(edificio);
        edificioDAO.crear(edificio);
    }

    public void actualizar(Edificio edificio) throws ValidacionException, PersistenciaException {
        if (edificio.getId() == null) {
            throw new ValidacionException("El id del edificio es obligatorio para actualizar.");
        }
        validar(edificio);
        edificioDAO.actualizar(edificio);
    }

    public void eliminar(int id) throws PersistenciaException {
        edificioDAO.eliminar(id);
    }

    public Edificio buscarPorId(int id) throws PersistenciaException {
        return edificioDAO.buscarPorId(id);
    }

    public List<Edificio> listarTodos() throws PersistenciaException {
        return edificioDAO.listarTodos();
    }

    public List<Edificio> reportePorCiudadYPisos(String ciudad, int pisosMin, int pisosMax) throws ValidacionException, PersistenciaException {
        if (ciudad == null || ciudad.isBlank()) {
            throw new ValidacionException("La ciudad es obligatoria.");
        }
        if (pisosMin > pisosMax) {
            throw new ValidacionException("El numero minimo de pisos no puede ser mayor que el maximo.");
        }
        return edificioDAO.reportePorCiudadYPisos(ciudad, pisosMin, pisosMax);
    }

    public List<Edificio> reportePorAdministracion(BigDecimal valorMin, BigDecimal valorMax,
                                                     Boolean conAscensor, Boolean conZonaSocial) throws ValidacionException, PersistenciaException {
        if (valorMin == null || valorMax == null || valorMin.compareTo(valorMax) > 0) {
            throw new ValidacionException("El rango de valor de administracion no es valido.");
        }
        return edificioDAO.reportePorAdministracion(valorMin, valorMax, conAscensor, conZonaSocial);
    }

    private void validar(Edificio e) throws ValidacionException {
        if (e.getNombre() == null || e.getNombre().isBlank()) {
            throw new ValidacionException("El nombre del edificio es obligatorio.");
        }
        if (e.getCiudad() == null || e.getCiudad().isBlank()) {
            throw new ValidacionException("La ciudad es obligatoria.");
        }
        if (e.getMetrosCuadrados() == null || e.getMetrosCuadrados().compareTo(BigDecimal.ZERO) <= 0) {
            throw new ValidacionException("Los metros cuadrados deben ser mayores a cero.");
        }
        if (e.getAltura() == null || e.getAltura().compareTo(BigDecimal.ZERO) <= 0) {
            throw new ValidacionException("La altura debe ser mayor a cero.");
        }
        if (e.getNumPisos() == null || e.getNumPisos() < 1) {
            throw new ValidacionException("El numero de pisos debe ser al menos 1.");
        }
        if (e.getValorAdministracion() == null || e.getValorAdministracion().compareTo(BigDecimal.ZERO) < 0) {
            throw new ValidacionException("El valor de administracion no puede ser negativo.");
        }
    }
}
