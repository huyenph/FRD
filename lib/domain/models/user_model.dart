class UserModel {
  const UserModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() => 'User{id: $id, name: $name}';
}
