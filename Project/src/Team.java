public class Team {

  private String name;
  private String iconPath;
  private String colors;
  private String hoh;
  private String captain;
  private String emblem;
  private String totChamps;

  Team(String name, String iconPath, String colors, String hoh, String captain, String emblem, String totChamps) {
    this.name = name;
    this.iconPath = iconPath;
    this.colors = colors;
    this.hoh = hoh;
    this.captain = captain;
    this.emblem = emblem;
    this.totChamps = totChamps;
  }

  String getName() {
    return this.name;
  }

  String getIconPath() {
    return this.iconPath;
  }

  String getColors() {
    return this.colors;
  }

  String getHoh() {
    return this.hoh;
  }

  String getCaptain() {
    return this.captain;
  }

  String getEmblem() {
    return this.emblem;
  }

  String getTotChamps() {
    return this.totChamps;
  }

  void updateFields(String hoh, String captain, String totChamps) {
    this.hoh = hoh;
    this.captain = captain;
    this.totChamps = totChamps;
  }

  /*void setHoh(String hoh) {
    this.hoh = hoh;
  }

  void setCaptain(String name) {
    this.captain = name;
  }*/

}
