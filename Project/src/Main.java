import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JFrame;

/**
 * A class to store the main method.
 */
public class Main {

  /**
   * A main method to connect to the sharkDB mySQL database.
   * <br> * First Command Line Argument --> username
   * <br> * Second Command Line Argument --> password
   *
   * @param args zero or more command line parameters
   */
  public static void main(String[] args) throws Exception {
    Connection con = null;

    Class.forName("com.mysql.cj.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/HarryPotter";
    String user = args[0];
    String pwd = args[1];

    try {
      con = DriverManager.getConnection(url, user, pwd);
    } catch (SQLException e) {
      throw new IllegalArgumentException(
          "Connection failed - please enter a valid username and password.");
    }

    Window.setDefaultLookAndFeelDecorated(false);
    Window w = new Window(con);
    w.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    w.setVisible(true);

    /* close the connection to the database */
    while(w.isEnabled());
    con.close();

  }
}
