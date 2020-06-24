class Post {
  final String id;
  final String title;
  final String description;

  const Post({
    this.id,
    this.title,
    this.description,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
      };
}
