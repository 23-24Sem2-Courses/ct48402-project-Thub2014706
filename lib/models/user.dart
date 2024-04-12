class User {
  final String? id;
  final String name;
  final String email;
  final String password;
  final bool isAdmin;
  final List<String> favorite;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.isAdmin = false,
    required this.favorite,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    bool? isAdmin,
    List<String>? favorite,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isAdmin: isAdmin ?? this.isAdmin,
      favorite: favorite ?? this.favorite,
    );
  }
}