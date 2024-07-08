import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String avatar;
  const UserModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserModel(id: $id, name: $name, avatar: $avatar)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.avatar == avatar;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ avatar.hashCode;
}
