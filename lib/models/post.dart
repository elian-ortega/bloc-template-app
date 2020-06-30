class Post {
  final String userId;
  final String userName;
  final String title;
  final String description;
  final String postId;
  final String imageUrl;
  final String imageFileName;

  const Post({
    this.imageUrl,
    this.postId,
    this.userId,
    this.userName,
    this.title,
    this.description,
    this.imageFileName,
  });

  Post.fromData(Map<String, dynamic> data, String postId)
      : postId = postId,
        userId = data['userId'],
        userName = data['userName'],
        title = data['title'],
        description = data['description'],
        imageUrl = data['imageUrl'],
        imageFileName = data['imageFileName'];

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'userName': userName,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'imageFileName': imageFileName,
      };
}
