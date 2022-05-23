package mx.com.upiicsa.ipn.proyectogestionescolar.bd;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao.DAOInitializationException;
import mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao.DataAccessObject;

//Heredamos del Data Access Object
public class Consulta extends DataAccessObject {
    private StringBuilder storedProcedure;
    
    /**
     * Realiza una consulta, ya sea select, call, insert, etc.
     * @param storedProcedure Procedimiento almacenado o sentencia.
     * @throws ClassNotFoundException
     * @throws SQLException 
     */
    public Consulta(String storedProcedure) throws ClassNotFoundException, SQLException {
        this.storedProcedure = new StringBuilder(storedProcedure);
    }
    /**
     * Obtiene la sentencia del objeto o el SP (Stored Procedure)
     * @return 
     */
    public StringBuilder getStoredProcedure() {
        return storedProcedure;
    }
    
    /**
     * Cambia el procedimiento almacenado a ejecutar/llamar
     * @param storedProcedure 
     */
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
    public ArrayList<ArrayList<Object>> leeMatriz() throws SQLException,DAOInitializationException{
        ArrayList<ArrayList<Object>> matriz = new ArrayList<ArrayList<Object>>();
        ArrayList<Object> registro;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            //Ejecutamos el StoredProcedure
            stmt = prepareStatement(this.storedProcedure.toString());
            stmt.execute();
            rs = stmt.getResultSet();
            //Por cada fila
            while(rs.next()){
                registro = new ArrayList<Object>();//Generamos instancia
                //Almacenamos los valores de las columnas
                for(short columna=1;columna<=rs.getMetaData().getColumnCount();columna++){
                    //System.out.println("Columna: " + columna);
                    registro.add(rs.getObject(columna));
                }
                //Guardamos la fila en la matriz
                matriz.add(registro);
            }
        } catch (SQLException e) {
            matriz = null;
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            //Cerramos el result set y el statement
            closeResultSet(rs);
            closeStatement(stmt);
            closeConnection();
        }
        return matriz;//Devolvemos la matriz leída
    }
    
    /**
     * Lee un registro (fila) de la BD, llamando al SP que contenga el objeto consulta
     * @return
     * @throws SQLException
     * @throws DAOInitializationException 
     */
    public ArrayList<Object> leeRegistro() throws SQLException,DAOInitializationException {
        ArrayList<Object> registro = new ArrayList<Object>();//Generamos instancia;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            //Ejecutamos el StoredProcedure
            stmt = prepareStatement(this.storedProcedure.toString());
            stmt.execute();
            rs = stmt.getResultSet();
            //Por cada fila
            if(rs.next()){
                //Almacenamos los valores de las columnas
                for(short columna=1;columna<=rs.getMetaData().getColumnCount();columna++){
                    //System.out.println("Columna: " + columna);
                    registro.add(rs.getObject(columna));
                }
            }
        } catch (SQLException e) {
            registro = null;
            System.out.println("Class Exception: " + e.getMessage());
        } finally {
            //Cerramos el result set y el statement
            closeResultSet(rs);
            closeStatement(stmt);
            closeConnection();
        }
        return registro;//Devolvemos el registro leído, si hay más de 1 se lee solo el primero
    }
}
