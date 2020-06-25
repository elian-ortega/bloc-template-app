class Post {
  final String userId;
  final String userName;
  final String title;
  final String description;
  final String postId;

  const Post({
    this.postId,
    this.userId,
    this.userName,
    this.title,
    this.description,
  });

  Post.fromData(Map<String, dynamic> data, String postId)
      : postId = postId,
        userId = data['userId'],
        userName = data['userName'],
        title = data['title'],
        description = data['description'];

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userName': userName,
        'title': title,
        'description': description,
      };
}
