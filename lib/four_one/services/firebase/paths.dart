class FirebasePath {
  static const Table = 'Table/';
  static String row(String uid)  => Table + uid;
  static String user(String uid) => 'Users/$uid';
}