/// Immutable model: fields are `final`, so a Blog can't change after it's
/// created. To "edit" one you'd create a new instance (often via copyWith).
class Blog {
  const Blog({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
    id: json['id'] as int,
    userId: json['userId'] as int,
    title: json['title'] as String,
    body: json['body'] as String,
  );

  final int id;
  final int userId;
  final String title;
  final String body;
}
