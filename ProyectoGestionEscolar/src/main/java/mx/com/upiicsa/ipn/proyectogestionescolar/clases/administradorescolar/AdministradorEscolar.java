package mx.com.upiicsa.ipn.proyectogestionescolar.clases.administradorescolar;

import java.sql.SQLException;
import java.util.ArrayList;
import mx.com.upiicsa.ipn.proyectogestionescolar.bd.Consulta;
import mx.com.upiicsa.ipn.proyectogestionescolar.bd.dao.DAOInitializationException;

public class AdministradorEscolar {
    public static void main(String[] args) throws ClassNotFoundException, SQLException, DAOInitializationException {
        Consulta consulta = new Consulta("CALL prueba_sp();");
        ArrayList<ArrayList<Object>> data = new ArrayList<ArrayList<Object>>();
        data=consulta.leeMatriz();
        for(ArrayList<Object> registro:data){
            for(Object campo:registro){
                System.out.println(campo.toString());
            }
        }
    }
}
