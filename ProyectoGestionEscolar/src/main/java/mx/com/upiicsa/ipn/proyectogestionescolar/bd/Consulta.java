package mx.com.upiicsa.ipn.proyectogestionescolar.bd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao.DAOInitializationException;
import mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao.DataAccessObject;

public class Consulta extends DataAccessObject {

    private StringBuilder storedProcedure;

    public Consulta(String storedProcedure) throws ClassNotFoundException, SQLException {
        this.storedProcedure = new StringBuilder(storedProcedure);
    }

    public StringBuilder getStoredProcedure() {
        return storedProcedure;
    }

    public void setStoredProcedure(StringBuilder storedProcedure) {
        this.storedProcedure = storedProcedure;
    }

    /**
     * Devuelve una matriz obtenida por un select, normalmente un procedimiento
     * almacenado
     * @return Matriz en forma de lista anidada en otra lista
     * @throws java.sql.SQLException
     * @throws mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao.DAOInitializationException
     */
    public ArrayList<ArrayList<Object>> leeMatriz() throws SQLException, DAOInitializationException {
        ArrayList<ArrayList<Object>> matriz = new ArrayList<ArrayList<Object>>();
        ArrayList<Object> registro = new ArrayList<Object>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            //Ejecutamos el StoredProcedure
            stmt = prepareStatement(this.storedProcedure.toString());
            stmt.execute();
            rs = stmt.getResultSet();
            //Por cada fila
            while(rs.next()){
                //Almacenamos los valores de las columnas
                for(short columna=0;columna<rs.getMetaData().getColumnCount();columna++){
                    registro.add(rs.getObject(columna));
                }
                //Guardamos la fila en la matriz
                matriz.add(registro);
                registro.clear();
            }
        } catch (SQLException e) {
            matriz = null;
        } finally {
            closeResultSet(rs);
            closeStatement(stmt);
        }
        return matriz;
    }
}
