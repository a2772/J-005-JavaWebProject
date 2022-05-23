package mx.com.upiicsa.ipn.proyectogestionescolar.business.alumno;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.upiicsa.ipn.proyectogestionescolar.bd.Consulta;
import mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao.DAOInitializationException;

/**
 * Clase para las funcionalidades que tendrán los alumnos
 * @author paris
 */
public class AlumnoBs {
    public static void main(String[] args) {
        //Probando
        ArrayList<ArrayList<Object>> lista;
        
        StringBuilder query = new StringBuilder();
        query.append("CALL sp_get_desplegable(");
        query.append("1);");
        try{
            Consulta consulta = new Consulta(query.toString());
            lista = consulta.leeMatriz();
            
            for(ArrayList<Object> registro : lista){
                for(Object campo:registro){
                    System.out.println("Campo: " + campo.toString());
                }
            }
        }catch(ClassNotFoundException | DAOInitializationException | SQLException ex){
            System.out.println("Campo: " + ex.getMessage());
        }
    }
}
