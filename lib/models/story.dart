class Story {
  final String storyTitle;
  final String category;

  const Story({
    this.storyTitle,
    this.category,
  });

  Story.fromData(Map<String, dynamic> data)
      : storyTitle = data['storyTitle'],
        category = data['category'];
}
