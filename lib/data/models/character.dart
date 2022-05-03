class Charter {
  final String name;
  final String status;
  final String location;
  String firstSeen;
  final String species;
  final String type;
  final String image;
  final String gender;

  Charter({
    required this.image,
    required this.name,
    required this.status,
    required this.location,
    required this.firstSeen,
    required this.species,
    required this.type,
    required this.gender,
  });

  Charter.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        status = json["status"],
        location = json["location"]["name"],
        firstSeen = "error",
        species = json["species"],
        type = json["type"],
        image = json["image"],
        gender = json["gender"];
}
