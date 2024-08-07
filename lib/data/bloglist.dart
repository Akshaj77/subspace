

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';


part 'bloglist.g.dart';

class BlogList {
  final List<Blog> blogs;
  BlogList({
    required this.blogs,
  });

  BlogList copyWith({
    List<Blog>? blogs,
  }) {
    return BlogList(
      blogs: blogs ?? this.blogs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'blogs': blogs.map((x) => x.toMap()).toList(),
    };
  }

  factory BlogList.fromMap(Map<String, dynamic> map) {
    return BlogList(
      blogs: List<Blog>.from((map['blogs'] as List<int>).map<Blog>((x) => Blog.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogList.fromJson(String source) => BlogList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'BlogList(blogs: $blogs)';

  @override
  bool operator ==(covariant BlogList other) {
    if (identical(this, other)) return true;
  
    return 
      listEquals(other.blogs, blogs);
  }

  @override
  int get hashCode => blogs.hashCode;
}

@HiveType(typeId: 0)
class Blog {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String image_url;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final bool isFavourite;

  Blog({
    required this.id,
    required this.image_url,
    required this.title,
    required this.isFavourite,
  });

  Blog copyWith({
    String? id,
    String? image_url,
    String? title,
    bool? isFavourite,
  }) {
    return Blog(
      id: id ?? this.id,
      image_url: image_url ?? this.image_url,
      title: title ?? this.title,
      isFavourite: isFavourite?? this.isFavourite ,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': image_url,
      'title': title,
      
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      id: map['id'] as String,
      image_url: map['image_url'] as String,
      title: map['title'] as String,
      isFavourite: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) => Blog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Blog(id: $id, image_url: $image_url, title: $title)';

  @override
  bool operator ==(covariant Blog other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.image_url == image_url &&
      other.title == title &&
      other.isFavourite == isFavourite
      ;
      
  }

  @override
  int get hashCode => id.hashCode ^ image_url.hashCode ^ title.hashCode ^ isFavourite.hashCode;
}