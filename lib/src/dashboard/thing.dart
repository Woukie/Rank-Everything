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
      id: int.parse(thing['id']),
      name: thing['name'],
      imageUrl: thing['image_url'],
      description: thing['description'],
      votes: int.parse(thing['votes']),
      adult: int.parse(thing['adult']) != 0,
    );
  }
}
