enum AccountRole { propertyManager, subContractor, user, business }

class UserModel {
  final String id;
  final String email;
  final String password;
  final AccountRole role;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'password': password,
        'role': role.name,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        role: AccountRole.values.firstWhere((e) => e.name == json['role']),
      );
}
