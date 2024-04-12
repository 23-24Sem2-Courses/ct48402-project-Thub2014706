class AuthToken {
  final String _token;
  final String _userId;
  final DateTime _expiryDate;
  final bool _isAdmin;

  AuthToken({
    token,
    userId,
    expiryDate,
    bool isAdmin = false,
  })  : _token = token,
        _userId = userId,
        _expiryDate = expiryDate,
        _isAdmin = isAdmin;

  bool get isValid {
    return token != null;
  }

  String? get token {
    if (_expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  DateTime get expiryDate {
    return _expiryDate;
  }

  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
      'isAdmin': _isAdmin,
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['authToken'],
      userId: json['userId'],
      expiryDate: DateTime.parse(json['expiryDate']),
      isAdmin: json['isAdmin'] ?? false,
    );
  }
}
