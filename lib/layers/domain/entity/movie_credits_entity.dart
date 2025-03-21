class MovieCreditEntity {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  MovieCreditEntity({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory MovieCreditEntity.fromJson(Map<String, dynamic> json) => MovieCreditEntity(
    adult: json["adult"],
    gender: json["gender"],
    id: json["id"],
    knownForDepartment: json["known_for_department"],
    name: json["name"],
    originalName: json["original_name"],
    popularity: json["popularity"]?.toDouble(),
    profilePath:
        json["profile_path"] == null || json["profile_path"] == ""
            ? "https://via.placeholder.com/150"
            : "https://image.tmdb.org/t/p/w500${json["profile_path"]}",
    castId: json["cast_id"],
    character: json["character"],
    creditId: json["credit_id"],
    order: json["order"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "gender": gender,
    "id": id,
    "known_for_department": knownForDepartment,
    "name": name,
    "original_name": originalName,
    "popularity": popularity,
    "profile_path": profilePath,
    "cast_id": castId,
    "character": character,
    "credit_id": creditId,
    "order": order,
  };

  @override
  bool operator ==(covariant MovieCreditEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.adult == adult &&
      other.gender == gender &&
      other.id == id &&
      other.knownForDepartment == knownForDepartment &&
      other.name == name &&
      other.originalName == originalName &&
      other.popularity == popularity &&
      other.profilePath == profilePath &&
      other.castId == castId &&
      other.character == character &&
      other.creditId == creditId &&
      other.order == order;
  }

  @override
  int get hashCode {
    return adult.hashCode ^
      gender.hashCode ^
      id.hashCode ^
      knownForDepartment.hashCode ^
      name.hashCode ^
      originalName.hashCode ^
      popularity.hashCode ^
      profilePath.hashCode ^
      castId.hashCode ^
      character.hashCode ^
      creditId.hashCode ^
      order.hashCode;
  }
}
