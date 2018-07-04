class Session {
  final bool isValid;
  final String username;
  final String password;

  Session({this.username, this.password, this.isValid = false});

  Map toJson() => {
        'isValid': isValid,
        'username': username,
        'password': password,
      };

  @override
  String toString() => "$username:$password";
}
