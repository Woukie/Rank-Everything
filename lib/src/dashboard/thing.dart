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
}
