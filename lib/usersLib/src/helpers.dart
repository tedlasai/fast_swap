List<String> setSearchParam(String username) {
  if (username != null && username != "") {
    List<String> caseSearchList = List();
    String temp = "";
    for (int i = 0; i < username.length; i++) {
      temp = temp + username[i];
      caseSearchList.add(temp);
    }
    return caseSearchList;
  } else {
    return null;
  }
}

String toLower(String username) {
  if (username != null) {
    return username.toLowerCase();
  } else {
    return null;
  }
}
