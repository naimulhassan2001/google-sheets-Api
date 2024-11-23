class UserFields {
  static final String email = "email";
  static final String id = "id";

  static final String name = "name";

  static final String isBeginner = "isBeginner";

  static List<String> getFields() => [email, id, name, isBeginner];
}

class UserModel {
  final String id;
  final String name;
  final String email;
  final String isBeginner;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.isBeginner,
  });

  factory UserModel.fromList(List<dynamic> data) {
    return UserModel(
      email: data.isNotEmpty ? data[0].toString() : "",
      id: data.length > 1 ? data[1].toString() : '',
      name: data.length > 2 ? data[2].toString() : "",
      isBeginner: data.length > 3 ? data[3].toString() : "false",
    );
  }

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.isBeginner: isBeginner,
      };
}
