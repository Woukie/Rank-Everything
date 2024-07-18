class Thing {
  final String name, imageUrl, description;
  final int votes, id;
  final bool adult;

  Thing({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.votes,
    required this.adult,
  });

  static Thing parse(dynamic thing) {
    return Thing(
      id: thing['id'],
      name: thing['name'],
      imageUrl: thing['image_url'],
      description: thing['description'],
      votes: thing['votes'],
      adult: thing['adult'] != 0,
    );
  }
}
