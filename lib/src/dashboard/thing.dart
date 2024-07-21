class Thing {
  final String name, imageUrl, description;
  final int likes, dislikes, id;
  final bool adult;

  Thing({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.likes,
    required this.dislikes,
    required this.adult,
  });

  static Thing parse(dynamic thing) {
    return Thing(
      id: thing['id'],
      name: thing['name'],
      imageUrl: thing['image_url'],
      description: thing['description'],
      likes: thing['likes'],
      dislikes: thing['dislikes'],
      adult: thing['adult'] != 0,
    );
  }

  int getPercentage() {
    if (likes + dislikes == 0) return 0;

    return likes * 100 ~/ (likes + dislikes);
  }
}
