// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ArticleModel {
  final String id;
  final String post;
  final String bgURL;
  final String createdAt;
  ArticleModel({
    required this.id,
    required this.post,
    required this.bgURL,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'post': post,
      'bgURL': bgURL,
      'createdAt': createdAt,
    };
  }

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'] as String,
      post: map['post'] as String,
      bgURL: map['bgURL'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ArticleModel.fromJson(String source) => ArticleModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ArticleModel copyWith({
    String? id,
    String? post,
    String? bgURL,
    String? createdAt,
  }) {
    return ArticleModel(
      id: id ?? this.id,
      post: post ?? this.post,
      bgURL: bgURL ?? this.bgURL,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'ArticleModel(id: $id, post: $post, bgURL: $bgURL, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant ArticleModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.post == post &&
      other.bgURL == bgURL &&
      other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      post.hashCode ^
      bgURL.hashCode ^
      createdAt.hashCode;
  }
}
