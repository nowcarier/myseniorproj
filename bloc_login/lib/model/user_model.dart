class User {
  int id;
  String username;
  String token;

  User({this.id, this.username, this.token});

  @override
  String toString() => 'User { name: $username';

  factory User.fromDatabaseJson(Map<String, dynamic> data) => User(
        id: data['id'],
        username: data['username'],
        token: data['token'],
      );

  Map<String, dynamic> toDatabaseJson() =>
      {"id": this.id, "username": this.username, "token": this.token};
}
