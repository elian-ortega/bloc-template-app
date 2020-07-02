import 'package:flutter/foundation.dart';

class Story {
  final String storyId;
  final String storyTitle;
  final String category;

  const Story({
    this.storyId,
    this.storyTitle,
    this.category,
  });

  Story.fromData({@required Map<String, dynamic> data, @required String storyId})
      : storyId = storyId,
        storyTitle = data['storyTitle'],
        category = data['category'];
}
