import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JLabel;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import java.awt.*;
import javax.swing.*;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.JTable;
import javax.swing.JComboBox;
import java.sql.Connection;
import javax.swing.table.DefaultTableModel;

public class Window extends JFrame implements ActionListener {

  Connection con;
  JComboBox<String> caughtSnitchBox;
  JComboBox<String> mnum;
  JLabel team1score;
  JLabel team2score;
  JComboBox<String> playersOrderBy;
  JComboBox<String> playersFilterBy;
  JComboBox<String> playersFilterByOptions;
  Map<String, Team> teams = new HashMap<>();
  Map<String, JCheckBox> winningTeam = new HashMap<>();
  Map<String, JPanel> teamButtons = new HashMap<>();
  JTabbedPane tp;
  JTable matchesTable;
  JComboBox<String> seasonsOrderBy;
  JComboBox<String> matchesOrderBy;
  JComboBox<String> champsFilter;
  JTable broomsTable;
  JTable injuriesTable;
  JTable seasonsTable;
  JPanel buttonsPlayer;
  JTable playersTable;
  JMenuItem log;
  String adminPwd = "goldenSnitch";
  boolean admin;
  ImageIcon cup = new ImageIcon("res\\trophy.png");
  JPanel buttonsBroom;
  JPanel buttonsMatch;
  JPanel buttonsSeason;
  JPanel buttonsInjury;
  DefaultTableModel model;
  DefaultTableModel pmodel;
  DefaultTableModel mmodel;
  DefaultTableModel imodel;
  DefaultTableModel smodel;
  String matchNUM;

  public Window(Connection con) throws Exception {
    super();
    this.con = con;
    admin = false;

    CallableStatement cStmt = con.prepareCall("{call allTeams()}");
    cStmt.execute();
    ResultSet rs = cStmt.getResultSet();
    while(rs.next()) {
      String teamName = rs.getString("House");
      cStmt = con.prepareCall("{? = call getCaptain(?)}");
      cStmt.registerOutParameter(1, Types.VARCHAR);
      cStmt.setInt(2, Integer.parseInt(rs.getString("Captain")));
      cStmt.execute();
      teams.put(teamName, new Team(teamName, "res\\"+teamName+"Crest.jpg",
          rs.getString("Colors"), rs.getString("Head_of_house"),
          cStmt.getString(1), rs.getString("Emblem"),
          rs.getString("Total_champs")));
    }

    JPanel homePane = new JPanel();
    JPanel mainPanel = new JPanel();
    JPanel trophyPanel = new JPanel(new GridLayout(1,2));
    trophyPanel.add(new JLabel(new ImageIcon("res/trophyBig.png")));
    homePane.setLayout(new FlowLayout());
    JLabel fieldPane = new JLabel("The Continued History of Quidditch at Hogwarts!\n");
    fieldPane.setFont(new Font(fieldPane.getFont().getName(), Font.BOLD, 25));
    homePane.add(fieldPane);
    mainPanel.setLayout(new GridLayout(2,2, 15, 10));
    mainPanel.setBorder(BorderFactory.createEmptyBorder());
    for (Map.Entry<String, Team> set :  teams.entrySet()) {
      Team h = set.getValue();
      JButton houseButton = new JButton(h.getName().toUpperCase(Locale.ROOT), new ImageIcon(h.getIconPath()));
      houseButton.setVerticalTextPosition(SwingConstants.BOTTOM);
      houseButton.setHorizontalTextPosition(SwingConstants.CENTER);
      houseButton.setBackground(Color.LIGHT_GRAY);
      houseButton.setBorder(BorderFactory.createEmptyBorder());
      houseButton.setContentAreaFilled(false);
      houseButton.setFont(new Font(houseButton.getFont().getName(), Font.BOLD, 15));
      JPanel lab = new JPanel();
      houseButton.setActionCommand(h.getName()+"Button");
      houseButton.addActionListener(this);
      lab.add(houseButton);
      mainPanel.add(lab);
    }

    homePane.add(mainPanel);
    JScrollPane mainPane = new JScrollPane(homePane);//mainPanel);
    mainPane.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
    mainPane.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);

    JPanel p1= homePane;
    JPanel p2=createMatchPanel();
    JPanel p3=createBroomPanel();
    JPanel p4=createPlayerPanel();
    JPanel p5=createSeasonPanel();
    tp=new JTabbedPane();
    tp.setBounds(5,5,700,650);
    tp.add("Home", p1);
    tp.addChangeListener(new ChangeListener() {
      @Override
      public void stateChanged(ChangeEvent e) {
        try {
          updateBroomTable();
          updateMatchTable();
          updateSeasonTable();
        } catch (Exception ex) {

        }
      }
    });
    tp.add("Matches",p2);
    tp.add("Brooms",p3);
    tp.add("Players", p4);
    tp.add("Seasons", p5);
    for (Map.Entry<String, Team> set :  teams.entrySet()) {
      String name = set.getKey();
      Team h = set.getValue();
      tp.add(h.getName(), new JScrollPane(createHousePanel(h)));
    }

    JMenuBar menuBar = new JMenuBar();
    log = new JMenuItem("Login");
    log.setActionCommand("login");
    log.addActionListener(this);
    JMenuItem menuTitle = new JMenuItem("The Continued History of Quidditch at Hogwarts");
    menuTitle.setIcon(cup);
    menuTitle.setActionCommand("menuHome");
    menuTitle.addActionListener(this);
    log.setComponentOrientation(ComponentOrientation.RIGHT_TO_LEFT);
    menuTitle.setComponentOrientation(ComponentOrientation.LEFT_TO_RIGHT);
    menuBar.add(menuTitle);
    menuBar.add(log);
    this.setJMenuBar(menuBar);
    this.add(tp);
    this.setSize(750,750);
    this.setLayout(null);
    this.setVisible(true);
    this.setDefaultCloseOperation(EXIT_ON_CLOSE);
  }

  private JPanel createMatchPanel() throws Exception {
    /* MATCHES PANEL */
    mmodel = new DefaultTableModel() {
      @Override
      public boolean isCellEditable(int row, int column) {
        return false;
      }
    };
    JPanel matchesPanel = new JPanel();
    JPanel optionsPanel = new JPanel(new GridLayout(1,2));
    JPanel orderPanel = new JPanel(new FlowLayout());
    JPanel filterPanel = new JPanel(new FlowLayout());
    JLabel matchTitle = new JLabel("All Quidditch Matches\n");//field);
    matchTitle.setFont(new Font("Dialog", Font.BOLD, 25));
    matchesPanel.add(matchTitle);
    String[] matchesOrdering = {"Season (oldest -> recent)", "Season (recent -> oldest)",
        "Total Points (low -> high)", "Total Points (high -> low)",
        "Points Differental (low -> high)", "Points Differental (high -> low)"};
    matchesOrderBy = new JComboBox<String>(matchesOrdering);
    matchesOrderBy.setActionCommand("orderMatches");
    matchesOrderBy.addActionListener(this);
    matchesOrderBy.setEditable(false);
    orderPanel.add(new JLabel("Order By: "));
    orderPanel.add(matchesOrderBy);
    optionsPanel.add(orderPanel);
    JButton matchesFilterButton = new JButton("Filters");
    matchesFilterButton.setActionCommand("matchesFilter");
    matchesFilterButton.addActionListener(this);
    filterPanel.add(new JLabel("Filter Options: "));
    filterPanel.add(matchesFilterButton);
    optionsPanel.add(new JLabel());
    matchesPanel.add(optionsPanel);
    CallableStatement stmt = con.prepareCall("{call getMatches()}");
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    String[] columnNames = {"Season", "Match Number", "Team1", "Team1 Score", "Team2", "Team2 Score"};
    matchesTable = new JTable();
    matchesTable.setModel(mmodel);
    JScrollPane scrollMatches = new JScrollPane(matchesTable);
    matchesTable.setFillsViewportHeight(true);
    matchesTable.setRowSelectionAllowed(true);
    matchesTable.setColumnSelectionAllowed(false);
    matchesTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    mmodel.setColumnIdentifiers(columnNames);
    while(rs.next()) {
      mmodel.addRow(new Object[]{rs.getString("Season"), rs.getString("Matchup_number"),
          rs.getString("Team1"), rs.getString("Team1_score"), rs.getString("Team2"),
          rs.getString("Team2_score")});
    }
    matchesTable.getSelectionModel().addListSelectionListener(new ListSelectionListener(){
      public void valueChanged(ListSelectionEvent event) {
        if(event.getValueIsAdjusting())
          matchWindow(matchesTable.getValueAt(matchesTable.getSelectedRow(), 0).toString(), matchesTable.getValueAt(matchesTable.getSelectedRow(), 1).toString());
      }
    });
    matchesPanel.add(scrollMatches);
    JButton addMatch = new JButton("Add Match");
    addMatch.setActionCommand("addMatch");
    addMatch.addActionListener(this);
    buttonsMatch = new JPanel(new GridLayout(1, 3, 20 , 10));
    buttonsMatch.add(new JLabel());
    buttonsMatch.add(addMatch);
    buttonsMatch.add(new JLabel());
    matchesPanel.add(buttonsMatch);
    buttonsMatch.setVisible(admin);
    return matchesPanel;
  }

  private JPanel createBroomPanel() throws Exception {
    /* BROOMS PANEL */
    JPanel broomsPanel = new JPanel();
    JLabel broomTitle = new JLabel("Quidditch Broomsticks\n");//field);
    broomTitle.setFont(new Font("Dialog", Font.BOLD, 25));
    broomsPanel.add(broomTitle);
    CallableStatement stmt = con.prepareCall("{call allBrooms()}");
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    model = new DefaultTableModel() {
      @Override
      public boolean isCellEditable(int row, int column) {
        return false;
      }
    };
    String[] broomsColumns = {"Broom ID", "Brand", "Model", "Acceleration"};
    model.setColumnIdentifiers(broomsColumns);
    broomsTable = new JTable();
    broomsTable.setModel(model);
    broomsTable.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);
    broomsTable.setFillsViewportHeight(true);
    broomsTable.setRowSelectionAllowed(true);
    broomsTable.setColumnSelectionAllowed(false);
    JScrollPane scroll = new JScrollPane(broomsTable);
    scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
    scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
    while(rs.next()) {
      model.addRow(new Object[]{rs.getString("Broom_id"), rs.getString("Brand"),
          rs.getString("Model"), rs.getString("Acceleration")});
    }
    broomsPanel.add(scroll);
    JButton addBrooms = new JButton("Add Broom");
    addBrooms.setActionCommand("addBroom");
    addBrooms.addActionListener(this);
    JButton delBrooms = new JButton("Delete Broom");
    delBrooms.setActionCommand("deleteBroom");
    delBrooms.addActionListener(this);
    buttonsBroom = new JPanel(new GridLayout(1, 3, 20 , 10));
    buttonsBroom.add(addBrooms);
    buttonsBroom.add(delBrooms);
    broomsPanel.add(buttonsBroom);
    buttonsBroom.setVisible(admin);
    return broomsPanel;
  }

  private JPanel createPlayerPanel() throws Exception {
    /* PLAYERS PANEL */
    pmodel = new DefaultTableModel() {
      @Override
      public boolean isCellEditable(int row, int column) {
        return false;
      }
    };
    JPanel playersPanel = new JPanel();
    JLabel playerTitle = new JLabel("All Quidditch Players\n");
    JPanel heading = new JPanel();
    playerTitle.setFont(new Font("Dialog", Font.BOLD, 25));
    playersPanel.add(playerTitle);
    String[] playersOrdering = {"Alphabetical (A -> Z)", "Alphabetical (Z -> A)",
        "Graduation Year (recent -> oldest)", "Graduation Year (oldest -> recent)",
        "Points Scored (high -> low)", "Points Scored (low -> high)"};
    playersOrderBy = new JComboBox<String>(playersOrdering);
    playersOrderBy.setActionCommand("orderPlayers");
    playersOrderBy.addActionListener(this);
    playersOrderBy.setEditable(false);
    heading.add(playersOrderBy);
    JButton playersFilterButton = new JButton("Filter By");
    playersFilterButton.setActionCommand("playersFilter");
    playersFilterButton.addActionListener(this);
    heading.add(playersFilterButton);
    JButton injuryButton = new JButton("View Injury Reports");
    injuryButton.setActionCommand("viewInjuries");
    injuryButton.addActionListener(this);
    heading.add(injuryButton);
    playersPanel.add(heading);
    String[] rosterColumns = {"ID", "Name", "Position", "Graduation", "Broom", "Points Scored"};;
    playersTable = new JTable();
    playersTable.setModel(pmodel);
    JScrollPane scrollplayers = new JScrollPane(playersTable);
    playersTable.setFillsViewportHeight(true);
    playersTable.setRowSelectionAllowed(true);
    playersTable.setColumnSelectionAllowed(false);
    playersTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    pmodel.setColumnIdentifiers(rosterColumns);
    CallableStatement stmt = con.prepareCall("{call getPlayers()}");
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    while (rs.next()) {
      pmodel.addRow(new Object[]{rs.getString("Player_id"), rs.getString("Name"),
          rs.getString("Position"), rs.getString("Grad_year"),
          rs.getString("Broom"), rs.getString("Points_scored")});
    }
    playersPanel.add(scrollplayers);
    JButton addPlayer = new JButton("Add");
    buttonsPlayer = new JPanel(new GridLayout(1, 3, 15 , 10));
    buttonsPlayer.add(addPlayer);
    playersPanel.add(buttonsPlayer);
    buttonsPlayer.setVisible(admin);
    return playersPanel;
  }

  private JPanel createSeasonPanel() throws Exception {
    /* SEASON PANEL */
    JPanel seasonPanel = new JPanel();
    JPanel optionsPanel = new JPanel(new GridLayout(1, 2));
    JPanel orderPanel = new JPanel(new FlowLayout());
    JPanel filterPanel = new JPanel(new FlowLayout());
    JLabel seasonTitle = new JLabel("Season Champions\n");
    seasonTitle.setHorizontalTextPosition(JLabel.CENTER);
    seasonTitle.setFont(new Font("Dialog", Font.BOLD, 25));
    seasonPanel.add(seasonTitle);
    String[] seasonsOrdering = {"Year (oldest -> recent)", "Year (recent -> oldest)"};
    seasonsOrderBy = new JComboBox<String>(seasonsOrdering);
    seasonsOrderBy.setActionCommand("orderSeasons");
    seasonsOrderBy.addActionListener(this);
    seasonsOrderBy.setEditable(false);
    orderPanel.add(new JLabel("Sort By: "));
    orderPanel.add(seasonsOrderBy);
    String[] seasonFilter = new String[5];
    seasonFilter[0] = "All";
    int i = 1;
    for(Map.Entry<String, Team> set :  teams.entrySet()) {
      seasonFilter[i] = set.getKey();
      i++;
    }
    champsFilter = new JComboBox<String>(seasonFilter);
    champsFilter.add(new JLabel("TEst"));
    champsFilter.setActionCommand("filterSeasons");
    champsFilter.addActionListener(this);
    champsFilter.setEditable(false);
    filterPanel.add(new JLabel("Filter By Winning Team: "));
    filterPanel.add(champsFilter);
    optionsPanel.add(orderPanel);
    optionsPanel.add(filterPanel);
    seasonPanel.add(optionsPanel);
    CallableStatement stmt = con.prepareCall("{call getSeasons()}");
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    smodel = new DefaultTableModel() {
      @Override
      public boolean isCellEditable(int row, int column) {
        return false;
      }
    };
    String[] seasonsColumns = {"Year", "Champions"};
    smodel.setColumnIdentifiers(seasonsColumns);
    seasonsTable = new JTable();
    seasonsTable.setModel(smodel);
    seasonsTable.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);
    seasonsTable.setFillsViewportHeight(true);
    seasonsTable.setRowSelectionAllowed(false);
    seasonsTable.setColumnSelectionAllowed(false);
    JScrollPane sscroll = new JScrollPane(seasonsTable);
    sscroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
    sscroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
    while(rs.next()) {
      smodel.addRow(new Object[]{rs.getString("Year"), rs.getString("Winning_team")});
    }
    seasonPanel.add(sscroll);
    buttonsSeason = new JPanel(new GridLayout(1, 3, 20, 10));
    JButton addSeason = new JButton("Add Season");
    addSeason.setActionCommand("addSeason");
    addSeason.addActionListener(this);
    buttonsSeason.add(new JLabel());
    buttonsSeason.add(addSeason);
    buttonsSeason.add(new JLabel());
    seasonPanel.add(buttonsSeason);
    buttonsSeason.setVisible(admin);
    return seasonPanel;
  }

  private JPanel createHousePanel(Team h) throws Exception {
    JPanel pan = new JPanel();
    JPanel stats = new JPanel();
    stats.setBorder(BorderFactory.createLineBorder(Color.black, 2));
    stats.setLayout(new GridLayout(5,4));
    stats.setFont(new Font("Dialog", Font.PLAIN, 15));
    JLabel colors = new JLabel("Colors: ");
    colors.setFont(new Font("Dialog", Font.BOLD, 15));
    JLabel emblem = new JLabel("Emblem: ");
    emblem.setFont(new Font("Dialog", Font.BOLD, 15));
    JLabel hoh = new JLabel("Head of House: ");
    hoh.setFont(new Font("Dialog", Font.BOLD, 15));
    JLabel cap = new JLabel("Captain: ");
    cap.setFont(new Font("Dialog", Font.BOLD, 15));
    JLabel tot = new JLabel("Total Championships: ");
    tot.setFont(new Font("Dialog", Font.BOLD, 15));
    stats.add(colors);
    stats.add(new Label(h.getColors()));
    stats.add(emblem);
    stats.add(new Label(h.getEmblem()));
    stats.add(hoh);
    stats.add(new Label(h.getHoh()));
    stats.add(cap);
    stats.add(new Label(h.getCaptain()));
    stats.add(tot);
    stats.add(new Label(h.getTotChamps()));

    JPanel header = new JPanel(new FlowLayout());
    header.setSize(600,600);
    JPanel title = new JPanel();
    title.setLayout(new GridLayout(2,1));
    JLabel name = new JLabel(h.getName());
    name.setFont(new Font(name.getFont().getName(), Font.BOLD, 75));
    title.add(name);
    title.add(stats);
    header.add(new JLabel(new ImageIcon(h.getIconPath())));
    header.add(title);

    JLabel rosterTitle = new JLabel("Roster");
    rosterTitle.setFont(new Font("Dialog", Font.BOLD, 25));
    JTable roster = new JTable();
    String[] playersOrdering = {"Graduation Year (recent -> oldest)", "Graduation Year (oldest -> recent)",
        "Points Scored (high -> low)", "Points Scored (low -> high)"};
    JComboBox<String> playersOrderBy = new JComboBox<String>(playersOrdering);
    playersOrderBy.addActionListener(this);
    playersOrderBy.setEditable(false);
    DefaultTableModel mmodel = new DefaultTableModel() {
      @Override
      public boolean isCellEditable(int row, int column) {
        return false;
      }
    };
    JButton playersFilterButton = new JButton("Filter By");
    playersFilterButton.setActionCommand("playersFilter");
    playersFilterButton.addActionListener(this);
    JPanel buttons = new JPanel(new GridLayout(1,2));
    JButton modCaptain = new JButton("Change Captain");
    modCaptain.setActionCommand(h.getName() + "-captain");
    modCaptain.addActionListener(this);
    JButton modHoh = new JButton("Change Head of House");
    modHoh.setActionCommand(h.getName() + "-hoh");
    modHoh.addActionListener(this);
    buttons.add(modCaptain);
    buttons.add(modHoh);
    buttons.setVisible(admin);
    teamButtons.put(h.getName(), buttons);
    JButton addPlayer = new JButton("Add");
    buttonsPlayer = new JPanel();
    buttonsPlayer.add(addPlayer);
    buttonsPlayer.setVisible(admin);
    JPanel orderFilter = new JPanel();
    orderFilter.add(playersOrderBy);
    orderFilter.add(playersFilterButton);

    pan.setLayout(new BoxLayout(pan, BoxLayout.Y_AXIS));
    pan.add(header);
    pan.add(buttons);
    return pan;
  }

  @Override
  public void actionPerformed(ActionEvent e) {
    String house = "";
    String action = e.getActionCommand();
    if(action.contains("-")) {
      String[] parts = e.getActionCommand().split("-");
      house = parts[0];
      action = parts[1];
    }
    try {
      switch(action) {
        case "menuHome":
          tp.setSelectedIndex(0);
          break;
        case "login":
          loginPrompt();
          break;
        case "GryffindorButton":
          tp.setSelectedIndex(8);
          break;
        case "HufflepuffButton":
          tp.setSelectedIndex(5);
          break;
        case "RavenclawButton":
          tp.setSelectedIndex(7);
          break;
        case "SlytherinButton":
          tp.setSelectedIndex(6);
          break;
        case "deleteBroom":
          deleteBroom();
          break;
        case "addBroom":
          addBroom();
          break;
        case "addSeason":
          addSeason();
          break;
        case "addMatch":
          addMatch();
          break;
        case "orderMatches":
          updateMatchTable();
          break;
        case "filterMatches":
          break;
        case "filterSeasons":
        case "orderSeasons":
          updateSeasonTable();
          break;
        case "addMatchNum":
          updateOptions();
          break;
        case "orderPlayers":
          updatePlayerTable();
          break;
        case "playersFilter":
          filterPlayers();
          break;
        case "changePlayerFilterOptions":
          changePlayerFilterOptions();
        case "captain":
          changeCaptain(house);
          forceClose();
          break;
        case "hoh":
          changeHoh(house);
          forceClose();
          break;
        case "viewInjuries":
          viewInjuries();
          break;
        case "addInjury":
          addInjury();
          break;
        case "deleteInjury":
          deleteInjury();
          break;
        default:
          break;
      }
    } catch (Exception excep) {
      System.out.println( excep.getMessage());
    }
  }

  private void loginPrompt() {
    JPanel panel = new JPanel();
    JLabel label = new JLabel("Please enter your admin password:");
    JPasswordField pass = new JPasswordField(10);
    panel.add(label);
    panel.add(pass);
    String[] options = new String[]{ "Cancel", "LOGIN"};
    int option = JOptionPane.showOptionDialog(null, panel, "Administrator Login",
        JOptionPane.NO_OPTION, JOptionPane.PLAIN_MESSAGE,
        null, options, options[1]);
    if(option == 1) // pressing LOGIN button
    {
      char[] password = pass.getPassword();
      String pwd = new String(password);
      admin = pwd.equals(adminPwd);
      if (admin) {
        log.removeActionListener(this);
        log.setText("Admin");
        JOptionPane.showMessageDialog(this, "As admin you may now modify the database.",
            "Sucessful Login", JOptionPane.INFORMATION_MESSAGE);
        admin = true;
        allowModification();
      } else {
        JOptionPane.showMessageDialog(this, "Incorrect password!\n"
                + "Admin password not recognized - you may not modify the database.",
            "Login Failed", JOptionPane.ERROR_MESSAGE);
      }
    }
  }

  private void allowModification() {
   buttonsBroom.setVisible(admin);
   buttonsMatch.setVisible(admin);
   buttonsPlayer.setVisible(admin);
   buttonsSeason.setVisible(admin);
   for (Map.Entry<String, JPanel> set :  teamButtons.entrySet()) {
     set.getValue().setVisible(admin);
   }
   buttonsInjury.setVisible(admin);
  }

  private void deleteBroom() throws Exception{
    CallableStatement cStmt = con.prepareCall("{call allBroomIds()}");
    cStmt.execute();
    ResultSet rs = cStmt.getResultSet();
    String res = "";
    while(rs.next()) {
      res += rs.getString(1) + ",";
    }
    String[] options = res.split(",");
    String broomID = (String)JOptionPane.showInputDialog(this,
        "Which broom would you like to delete?\n" + "ID: ","Delete Broom",
        JOptionPane.PLAIN_MESSAGE,null, options,0);
    if ((broomID != null) && (broomID.length() > 0)) {
      cStmt = con.prepareCall("{call delBroom(?)}");
      cStmt.setInt("Broom_id", Integer.parseInt(broomID));
      cStmt.execute();
      updateBroomTable();
    }
  }

  private void addBroom() throws Exception {
    JTextField xField = new JTextField(15);
    JTextField yField = new JTextField(15);
    JTextField zField = new JTextField(15);

    JPanel myPanel = new JPanel();
    myPanel.add(new JLabel("Brand:"));
    myPanel.add(xField);
    myPanel.add(Box.createHorizontalStrut(15)); // a spacer
    myPanel.add(new JLabel("Model:"));
    myPanel.add(yField);
    myPanel.add(Box.createHorizontalStrut(15)); // a spacer
    myPanel.add(new JLabel("Acceleration:"));
    myPanel.add(zField);
    String[] options = new String[]{ "Cancel", "ADD"};
    int result = JOptionPane.showOptionDialog(null, myPanel,
        "Please Enter Broom Attributes", JOptionPane.NO_OPTION, JOptionPane.PLAIN_MESSAGE,
        null, options, null);//JOptionPane.OK_CANCEL_OPTION);
    if (result == 1) {
      CallableStatement stmt = con.prepareCall("{call addBroom(?,?,?)}");
      stmt.setString("Brand", xField.getText());
      stmt.setString("Model", yField.getText());
      stmt.setInt("Acceleration", Integer.parseInt(zField.getText()));
      stmt.execute();
      updateBroomTable();
    }
  }

  void updateBroomTable() throws Exception {
    CallableStatement stmt = con.prepareCall("{call allBrooms()}");
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    int count = model.getRowCount();
    for(int i = 0; i < count; i++) {
      model.removeRow(0);
    }
    while(rs.next()) {
      model.addRow(new Object[]{rs.getString("Broom_id"), rs.getString("Brand"),
          rs.getString("Model"), rs.getString("Acceleration")});
    }
    broomsTable.repaint();
    broomsTable.revalidate();
  }

  private void viewInjuries() throws Exception {
    JFrame jFrame = new JFrame();
    JDialog jd = new JDialog(jFrame);
    jd.setBounds(500, 100, 600, 600);
    jd.setLayout(new FlowLayout());
    JPanel top = new JPanel();
    top.setLayout(new BoxLayout(top, BoxLayout.Y_AXIS));
    JLabel injuryTitle = new JLabel("Injury Reports\n");
    injuryTitle.setFont(new Font("Dialog", Font.BOLD, 25));
    top.add(injuryTitle);
    CallableStatement stmt = con.prepareCall("{call getInjuries()}");
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    imodel = new DefaultTableModel() {
      @Override
      public boolean isCellEditable(int row, int column) {
        return false;
      }
    };
    String[] injuriesColumns = {"Player ID", "Name", "Afflicted Body Part", "Description"};
    imodel.setColumnIdentifiers(injuriesColumns);
    injuriesTable = new JTable();
    injuriesTable.setModel(imodel);
    injuriesTable.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);
    injuriesTable.setFillsViewportHeight(true);
    injuriesTable.setRowSelectionAllowed(false);
    injuriesTable.setColumnSelectionAllowed(false);
    JScrollPane scroll = new JScrollPane(injuriesTable);
    scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
    scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
    while(rs.next()) {
      imodel.addRow(new Object[]{rs.getString("Player_id"), rs.getString("Name"),
          rs.getString("Afflicted_body_part"), rs.getString("Description")});
    }
    top.add(scroll);
    jd.add(top);
    JButton addInjury = new JButton("Add Report");
    addInjury.setActionCommand("addInjury");
    addInjury.addActionListener(this);
    JButton delInjury = new JButton("Delete Report");
    delInjury.setActionCommand("deleteInjury");
    delInjury.addActionListener(this);
    buttonsInjury = new JPanel(new GridLayout(1, 3, 20 , 10));
    buttonsInjury.add(addInjury);
    buttonsInjury.add(delInjury);
    jd.add(buttonsInjury);
    buttonsInjury.setVisible(admin);
    jd.setVisible(true);
  }

  private void matchWindow(String season, String matchNum) {
    try {
      JFrame jFrame = new JFrame();
      jFrame.setTitle("Match Details");
      JDialog jd = new JDialog(jFrame);
      jd.setTitle("Match Details");
      int rowCount = 5;
      if (admin) rowCount++;
      jd.setLayout(new GridLayout(rowCount,1));
      jd.setBounds(500, 300, 400, 400);
      CallableStatement stmt = con.prepareCall("{call getMatchInfo(?,?)}");
      stmt.setInt("season", Integer.parseInt(season));
      stmt.setInt("matchNum", Integer.parseInt(matchNum));
      stmt.execute();
      ResultSet rs = stmt.getResultSet();
      rs.next();
      JPanel scorePanel = new JPanel(new GridLayout(2, 1));
      scorePanel.add(new JLabel("Score: "));
      model = new DefaultTableModel() {
        @Override
        public boolean isCellEditable(int row, int column) {
          return false;
        }
      };
      jd.add(new JLabel("Date: " + rs.getString("Month") + " " + season));
      String[] teams = {rs.getString("Team1"), rs.getString("Team2")};
      model.setColumnIdentifiers(teams);
      JTable scoreBoard = new JTable();
      scoreBoard.setModel(model);
      scoreBoard.setAutoResizeMode(JTable.AUTO_RESIZE_ALL_COLUMNS);
      scoreBoard.setFillsViewportHeight(true);
      scoreBoard.setShowHorizontalLines(false);
      scoreBoard.setRowSelectionAllowed(false);
      scoreBoard.setColumnSelectionAllowed(false);
      JScrollPane scroll = new JScrollPane(scoreBoard);
      scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED);
      scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
      model.addRow(new Object[]{rs.getString("Team1_score"), rs.getString("Team2_score")});
      scorePanel.add(scroll);
      jd.add(scorePanel);
      jd.add(new JLabel("Caught Snitch: " + rs.getString("Team_caught_snitch")));
      JPanel weather = new JPanel(new GridLayout(2, 1));
      weather.add(new JLabel("Weather Description: "));
      weather.add(new JLabel("\t" + rs.getString("Weather_desc")));
      jd.add(weather);
      JPanel tabInfo = new JPanel(new GridLayout(1,2));

      DefaultTableModel rmodel = new DefaultTableModel() {
        @Override
        public boolean isCellEditable(int row, int column) {
          return false;
        }
      };
      JTable refTable = new JTable();
      String[] columnNames = {"Referees"};
      refTable.setModel(rmodel);
      JScrollPane scrollRef = new JScrollPane(refTable);
      refTable.setFillsViewportHeight(true);
      refTable.setRowSelectionAllowed(false);
      refTable.setColumnSelectionAllowed(false);
      rmodel.setColumnIdentifiers(columnNames);
      stmt = con.prepareCall("{call getRef(?,?)}");
      stmt.setInt("Season_No", Integer.parseInt(season));
      stmt.setInt("Match_No", Integer.parseInt(matchNum));
      stmt.execute();
      rs = stmt.getResultSet();
      while(rs.next())
        rmodel.addRow(new Object[]{rs.getString("RefereeName")});
      tabInfo.add(scrollRef);

      DefaultTableModel cmodel = new DefaultTableModel() {
        @Override
        public boolean isCellEditable(int row, int column) {
          return false;
        }
      };
      JTable comTable = new JTable();
      String[] comColumnNames = {"Commentators"};
      comTable.setModel(cmodel);
      JScrollPane scrollCom = new JScrollPane(comTable);
      comTable.setFillsViewportHeight(true);
      comTable.setRowSelectionAllowed(false);
      comTable.setColumnSelectionAllowed(false);
      cmodel.setColumnIdentifiers(comColumnNames);
      stmt = con.prepareCall("{call getComm(?,?)}");
      stmt.setInt("Season_No", Integer.parseInt(season));
      stmt.setInt("Match_No", Integer.parseInt(matchNum));
      stmt.execute();
      rs = stmt.getResultSet();
      while(rs.next())
        cmodel.addRow(new Object[]{rs.getString("CommentatorName")});
      tabInfo.add(scrollCom);

      jd.add(tabInfo);
      if(admin) {
        JPanel editPanel = new JPanel(new GridLayout(1, 2, 10, 10));
        JButton addRefButton = new JButton("Add Referee");
        addRefButton.addActionListener(new ActionListener() {
          @Override
          public void actionPerformed(ActionEvent e) {
            try {
              String refName = addRef(season, matchNum);
              if(refName != null)
                rmodel.addRow(new Object[]{refName});
            } catch (Exception ex) {
              System.out.println(ex.getMessage());
            }
          }
        });
        JButton addCommButton = new JButton("Add Commentator");
        addCommButton.addActionListener(new ActionListener() {
          @Override
          public void actionPerformed(ActionEvent e) {
            try {
              String commName = addComm(season, matchNum);
              if(commName != null)
                cmodel.addRow(new Object[]{commName});
            } catch (Exception ex) {
              System.out.println(ex.getMessage());
            }
          }
        });
        editPanel.setMaximumSize(new Dimension(10,10));
        editPanel.add(addRefButton);
        editPanel.add(addCommButton);
        jd.add(editPanel);
      }
      jd.setVisible(true);
    } catch (Exception ex) {
      System.out.println(ex.getMessage() + season + matchNum);
    }
  }

  private String addRef(String season, String match) throws Exception {
    String ref = (String)JOptionPane.showInputDialog(
        this,
        "Enter the name of the referee:\n",
        "Add Referee",
        JOptionPane.PLAIN_MESSAGE,
        null,
        null,
        "Referee Name");
    if(ref != null && !ref.equals("Referee Name")) {
      CallableStatement stmt = con.prepareCall("{call assignRefToMatch(?, ?, ?)}");
      stmt.setString("Name", ref);
      stmt.setInt("Match_No", Integer.parseInt(match));
      stmt.setInt("Season", Integer.parseInt(season));
      stmt.execute();
      return ref;
    }
    return null;
  }

  private String addComm(String season, String match) throws Exception {
    String comm = (String)JOptionPane.showInputDialog(
        this,
        "Enter the name of the commentator:\n",
        "Add Commentator",
        JOptionPane.PLAIN_MESSAGE,
        null,
        null,
        "Commentator Name");
    if(comm != null && !comm.equals("Commentator Name")) {
      CallableStatement stmt = con.prepareCall("{call assignCommToMatch(?, ?, ?)}");
      stmt.setString("Name", comm);
      stmt.setInt("Match_No", Integer.parseInt(match));
      stmt.setInt("Season", Integer.parseInt(season));
      stmt.execute();
      return comm;
    }
    return null;
  }

  private void addSeason() throws Exception {
    JTextField xField = new JTextField(4);

    JPanel myPanel = new JPanel();
    myPanel.add(new JLabel("Year:"));
    myPanel.add(xField);
    myPanel.add(Box.createHorizontalStrut(15)); // a spacer
    myPanel.add(new JLabel("Winning Team:"));
    String[] options = new String[]{ "Cancel", "ADD"};
    String[] teamNames = teams.keySet().toArray(new String[0]);
    JComboBox<String> teamList = new JComboBox<String>(teamNames);
    myPanel.add(teamList);
    int result = JOptionPane.showOptionDialog(null, myPanel,
        "Please Enter Season Information", JOptionPane.NO_OPTION, JOptionPane.PLAIN_MESSAGE,
        null, options, null);
    if (result == 1) {
      CallableStatement stmt = con.prepareCall("{call addSeason(?,?)}");
      stmt.setString("yr", xField.getText());
      stmt.setString("Winning_team", teamList.getSelectedItem().toString());
      stmt.execute();
      updateSeasonTable();
    }

  }

  private void updateSeasonTable() throws Exception {
    CallableStatement stmt = con.prepareCall("{call orderSeasons(?,?)}");
    stmt.setInt("des", seasonsOrderBy.getSelectedIndex());
    stmt.setString("champs", champsFilter.getSelectedItem().toString());
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    int count = smodel.getRowCount();
    for(int i = 0; i < count; i++) {
      smodel.removeRow(0);
    }
    while(rs.next()) {
      smodel.addRow(new Object[]{rs.getString("Year"), rs.getString("Winning_team")});
    }
    seasonsTable.repaint();
    seasonsTable.revalidate();
  }

  private void addMatch() throws Exception {
    JTextField season = new JTextField(4);
    JTextField score1 = new JTextField(4);
    JTextField score2 = new JTextField(4);
    JTextField weather = new JTextField(64);
    CallableStatement cStmt = con.prepareCall("{call allMatchups()}");
    cStmt.execute();
    ResultSet rs = cStmt.getResultSet();
    String[] matchnumoptions = new String[6];
    int i = 0;
    while(rs.next()) {
      matchnumoptions[i] = rs.getString("Matchup_number") + " - "
          + rs.getString("Team1") + " vs " + rs.getString("Team2");
      i++;
    }
    mnum = new JComboBox<String>(matchnumoptions);
    mnum.setActionCommand("addMatchNum");
    mnum.addActionListener(this);
    matchNUM = mnum.getSelectedItem().toString().substring(0,1);
    caughtSnitchBox = new JComboBox<>(mnum.getSelectedItem().toString().substring(4).split(" vs "));
    team1score = new JLabel(caughtSnitchBox.getItemAt(0) + " Score:");
    team2score = new JLabel(caughtSnitchBox.getItemAt(1) + " Score:");
    JPanel myPanel = new JPanel(new GridLayout(3,1));
    JPanel topPanel = new JPanel();
    JPanel midPanel = new JPanel();
    JPanel sPanel = new JPanel();
    sPanel.add(new JLabel("Season:"));
    sPanel.add(season);
    JPanel mPanel = new JPanel();
    mPanel.add(new JLabel("Match Num:"));
    mPanel.add(mnum);
    JPanel cPanel = new JPanel();
    cPanel.add(new JLabel("Caught Snitch:"));
    cPanel.add(caughtSnitchBox);
    topPanel.add(sPanel);
    topPanel.add(mPanel);
    topPanel.add(cPanel);
    myPanel.add(topPanel);
    JPanel panel1 = new JPanel();
    panel1.add(team1score);
    panel1.add(score1);
    JPanel panel2 = new JPanel();
    panel2.add(team2score);
    panel2.add(score2);
    midPanel.add(panel1);
    midPanel.add(panel2);
    myPanel.add(midPanel);
    JPanel wPanel = new JPanel();
    wPanel.add(new JLabel("Weather Description:"));
    wPanel.add(weather);
    myPanel.add(wPanel);
    String[] options = new String[]{ "Cancel", "ADD"};
    int result = JOptionPane.showOptionDialog(null, myPanel,
        "Please Enter Match Information", JOptionPane.NO_OPTION, JOptionPane.PLAIN_MESSAGE,
        null, options, null);
    if (result == 1) {
      CallableStatement stmt = con.prepareCall("{call addMatch(?,?,?,?,?,?)}");
      stmt.setInt("Matchup_number", Integer.parseInt(matchNUM));
      stmt.setInt("Season", Integer.parseInt(season.getText()));
      stmt.setString("Team_caught_snitch", caughtSnitchBox.getSelectedItem().toString());
      stmt.setString("Weather_desc", weather.getText());
      stmt.setInt("Team1_Score", Integer.parseInt(score1.getText()));
      stmt.setInt("Team2_Score", Integer.parseInt(score2.getText()));
      stmt.execute();
      updateMatchTable();
    }
  }

  private void updateOptions() {
    caughtSnitchBox.removeAllItems();
    matchNUM = mnum.getSelectedItem().toString().substring(0,1);
    String[] validTeams = mnum.getSelectedItem().toString().substring(4).split(" vs ");
    team1score.setText(validTeams[0] + " Score:");
    team2score.setText(validTeams[1] + " Score:");
    caughtSnitchBox.addItem(validTeams[0]);
    caughtSnitchBox.addItem(validTeams[1]);
  }

  private void updateMatchTable() throws Exception {
    CallableStatement stmt = con.prepareCall("{call orderMatches(?,?)}");
    stmt.setInt("des", matchesOrderBy.getSelectedIndex()%2);
    String field = "Season";
    if(matchesOrderBy.getSelectedIndex() == 2 || matchesOrderBy.getSelectedIndex() == 3)
      field = "Total";
    else if (matchesOrderBy.getSelectedIndex() == 4 || matchesOrderBy.getSelectedIndex() == 5)
      field = "Differential";
    stmt.setString("field", field);
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    int count = mmodel.getRowCount();
    for(int i = 0; i < count; i++) {
      mmodel.removeRow(0);
    }
    while(rs.next()) {
      mmodel.addRow(new Object[]{rs.getString("Season"), rs.getString("Matchup_number"),
          rs.getString("Team1"), rs.getString("Team1_score"), rs.getString("Team2"),
          rs.getString("Team2_score")});
    }
    matchesTable.repaint();
    matchesTable.revalidate();
  }

  private void updatePlayerTable() throws Exception {
    try {
      CallableStatement stmt = con
          .prepareCall("{call orderPlayers(?,?,?,?}");
      stmt.setInt("des", playersOrderBy.getSelectedIndex() % 2);
      String field = "Alpha";
      if (playersOrderBy.getSelectedIndex() == 2 || playersOrderBy.getSelectedIndex() == 3)
        field = "Grad";
      else if (playersOrderBy.getSelectedIndex() == 4 || playersOrderBy.getSelectedIndex() == 5)
        field = "Points";
      stmt.setString("field", field);
      stmt.setString("filterField", "Position");
      stmt.setString("filterValue", "keeper");
      stmt.execute();
      ResultSet rs = stmt.getResultSet();
      int count = pmodel.getRowCount();
      for (int i = 0; i < count; i++) {
        pmodel.removeRow(0);
      }
      while (rs.next()) {
        pmodel.addRow(new Object[]{rs.getString("Player_id"), rs.getString("Name"),
            rs.getString("Position"), rs.getString("Grad_year"),
            rs.getString("Broom"), rs.getString("Points_scored")});
      }
      playersTable.repaint();
      playersTable.revalidate();
    } catch (Exception ex) {
      System.out.println(ex.getMessage());
    }
  }

  private void filterPlayers() throws Exception {
    String[] filterByOptions = {"Graduation Year", "Position", "Broom"};
    playersFilterBy = new JComboBox<>(filterByOptions);
    playersFilterBy.setActionCommand("changePlayerFilterOptions");
    playersFilterBy.addActionListener(this);
    playersFilterByOptions = new JComboBox<>();
    changePlayerFilterOptions();
    JPanel filterPanel = new JPanel();
    filterPanel.add(new JLabel("Filter By: "));
    filterPanel.add(playersFilterBy);
    filterPanel.add(new JLabel("With Value: "));
    filterPanel.add(playersFilterByOptions);
    String[] options = new String[]{ "Cancel", "FILTER"};

    int result = JOptionPane.showOptionDialog(null, filterPanel,
        "Please Enter Match Information", JOptionPane.NO_OPTION, JOptionPane.PLAIN_MESSAGE,
        null, options, null);
    if (result == 1) {
      updatePlayerTable();
    }
  }

  private void changePlayerFilterOptions() throws Exception{
    playersFilterByOptions.removeAllItems();
    switch(playersFilterBy.getSelectedItem().toString()) {
      case "Graduation Year":
        CallableStatement stmt = con.prepareCall("{call getPlayers()}");
        stmt.execute();
        ResultSet rs = stmt.getResultSet();
        while(rs.next()) {
          String model = "";
          playersFilterByOptions.addItem(rs.getString("Grad_year").substring(0,4));
        }
        break;
      case "Position":
        playersFilterByOptions.addItem("keeper");
        playersFilterByOptions.addItem("seeker");
        playersFilterByOptions.addItem("chaser");
        playersFilterByOptions.addItem("beater");
        break;
      case "Broom":
        stmt = con.prepareCall("{call allBrooms()}");
        stmt.execute();
        rs = stmt.getResultSet();
        while(rs.next()) {
          String model = "";
          if(rs.getString("Model") != null)
            model = rs.getString("Model");
          playersFilterByOptions.addItem(rs.getString("Broom_id") + " - "
              + rs.getString("Brand") + " " + model);
        }
        break;
    }
  }

  private void changeCaptain(String house) throws Exception {
    CallableStatement cStmt = con.prepareCall("{call getPlayers()}");
    cStmt.execute();
    ResultSet rs = cStmt.getResultSet();
    String res = "";
    while(rs.next()) {
      res += rs.getString("Player_id") + "-"+rs.getString("Name") + ",";
    }
    String[] options = res.split(",");
    String cap = (String)JOptionPane.showInputDialog(this,
        "Which player would you like to set as captain?\n" + "ID: ","Change Captain",
        JOptionPane.PLAIN_MESSAGE,null, options,0);
    if ((cap != null) && (cap.length() > 0)) {
      cStmt = con.prepareCall("{call modCap(?,?)}");
      cStmt.setString("House", house);
      cStmt.setInt("Player_id", Integer.parseInt(cap.split("-")[0]));
      cStmt.execute();
    }
  }

  private void changeHoh(String house) throws Exception {
    System.out.println("HOH");
    JTextField xField = new JTextField(64);
    JTextField yearField = new JTextField(4);
    JPanel myPanel = new JPanel();
    myPanel.add(new JLabel("New Head of House Name:"));
    myPanel.add(xField);
    myPanel.add(Box.createHorizontalStrut(15)); // a spacer
    myPanel.add(new JLabel("Start Year:"));
    myPanel.add(yearField);
    myPanel.add(Box.createHorizontalStrut(15)); // a spacer
    String[] options = new String[]{ "Cancel", "CHANGE"};
    int result = JOptionPane.showOptionDialog(null, myPanel,
        "Please Enter the New Head of House", JOptionPane.NO_OPTION, JOptionPane.PLAIN_MESSAGE,
        null, options, null);
    if (result == 1) {
      CallableStatement cStmt = con.prepareCall("{call modHoH(?,?,?)}");
      cStmt.setString("House", house);
      cStmt.setString("Name", xField.getText());
      cStmt.setString("Start_year", yearField.getText());
      cStmt.execute();
    }
  }

  private void forceClose() throws Exception {
    JOptionPane.showMessageDialog(this,
        "The page will now be restarted to update the changes made.",
        "Restart Required",
        JOptionPane.WARNING_MESSAGE);
    for(int i = 0; i < 4; i++)
      tp.removeTabAt(5);
    CallableStatement cStmt = con.prepareCall("{call allTeams()}");
    cStmt.execute();
    ResultSet rs = cStmt.getResultSet();
    while(rs.next()) {
      String teamName = rs.getString("House");
      cStmt = con.prepareCall("{? = call getCaptain(?)}");
      cStmt.registerOutParameter(1, Types.VARCHAR);
      cStmt.setInt(2, Integer.parseInt(rs.getString("Captain")));
      cStmt.execute();
      teams.put(teamName, new Team(teamName, "res/"+teamName+"Crest.jpg",
          rs.getString("Colors"), rs.getString("Head_of_house"),
          cStmt.getString(1), rs.getString("Emblem"),
          rs.getString("Total_champs")));
    }
    for (Map.Entry<String, Team> set :  teams.entrySet()) {
      String name = set.getKey();
      Team h = set.getValue();
      tp.add(h.getName(), new JScrollPane(createHousePanel(h)));
    }
    tp.setSelectedIndex(0);
  }

  private void updateInjuryTable() throws Exception {
    CallableStatement stmt = con.prepareCall("{call getInjuries()}");//con.prepareCall("{call getSeasons()}");
    stmt.execute();
    ResultSet rs = stmt.getResultSet();
    int count = imodel.getRowCount();
    for(int i = 0; i < count; i++) {
      imodel.removeRow(0);
    }
    while(rs.next()) {
      imodel.addRow(new Object[]{rs.getString("Player_id"), rs.getString("Name"),
          rs.getString("Afflicted_body_part"), rs.getString("Description")});
    }
    injuriesTable.setVisible(true);
    injuriesTable.repaint();
    injuriesTable.revalidate();
  }

  private void addInjury() throws Exception {
    CallableStatement cStmt = con.prepareCall("{call getPlayers()}");
    cStmt.execute();
    ResultSet rs = cStmt.getResultSet();
    String res = "";
    while(rs.next()) {
      res += rs.getString("Player_id") + "-"+rs.getString("Name") + ",";
    }
    String[] options = res.split(",");
    JComboBox<String> id = new JComboBox<>(options);
    JTextField bodyPart = new JTextField(64);
    JTextField desc = new JTextField(64);

    JPanel myPanel = new JPanel();
    myPanel.add(new JLabel("Player:"));
    myPanel.add(id);
    myPanel.add(Box.createHorizontalStrut(15)); // a spacer
    myPanel.add(new JLabel("Afflicted Body Part:"));
    myPanel.add(bodyPart);
    myPanel.add(Box.createHorizontalStrut(15)); // a spacer
    myPanel.add(new JLabel("Description:"));
    myPanel.add(desc);
    String[] boptions = new String[]{ "Cancel", "ADD"};
    int result = JOptionPane.showOptionDialog(null, myPanel,
        "Please Enter Injury Report", JOptionPane.NO_OPTION, JOptionPane.PLAIN_MESSAGE,
        null, boptions, null);//JOptionPane.OK_CANCEL_OPTION);
    if (result == 1) {
      CallableStatement stmt = con.prepareCall("{call addInj(?,?,?)}");
      stmt.setString("Afflicted_body_part", bodyPart.getText());
      stmt.setString("Description", desc.getText());
      stmt.setInt("Player_id", Integer.parseInt(id.getSelectedItem().toString().split("-")[0]));
      stmt.execute();
      updateInjuryTable();
    }
  }

  private void deleteInjury() throws Exception {
    CallableStatement cStmt = con.prepareCall("{call getInjuries()}");
    cStmt.execute();
    ResultSet rs = cStmt.getResultSet();
    String res = "";
    while(rs.next()) {
      res += rs.getString("Player_id") + ",";
    }
    String[] options = res.split(",");
    String playerID = (String)JOptionPane.showInputDialog(this,
        "Which injury report would you like to delete?\n" + "ID: ","Delete Report",
        JOptionPane.PLAIN_MESSAGE,null, options,0);
    if ((playerID != null) && (playerID.length() > 0)) {
      cStmt = con.prepareCall("{call delInj(?)}");
      cStmt.setInt("Player_id", Integer.parseInt(playerID));
      cStmt.execute();
      updateInjuryTable();
    }
  }
}
