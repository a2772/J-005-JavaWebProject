package mx.com.upiicsa.ipn.proyectogestionescolar.bd;

public class Conexion {
    public static class MySQL{
        private static final String DRIVER = "com.mysql.jdbc.Driver";
        private static final String URL = "jdbc:mysql://localhost:3306/gestion?serverTimezone=UTC";
        private static final String USER = "root";
        private static final String PASSWORD = "EmEElOyd?!27$r00t";
        
        public static String getDriver() {
            return DRIVER;
        }
        public static String getUrl() {
            return URL;
        }
        public static String getUser() {
            return USER;
        }
        public static String getPassword() {
            return PASSWORD;
        }
    }
}
