class LibraryModel {
  String? imageUrl;
  String? libraryTitle;
  String? librarySubTitle;
  bool? isFavourite;

  LibraryModel({
    this.imageUrl,
    this.libraryTitle,
    this.librarySubTitle,
    this.isFavourite,
  });

  LibraryModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"]?.toString();
    libraryTitle = json["libraryTitle"]?.toString();
    librarySubTitle = json["librarySubTitle"]?.toString();
    isFavourite = json["isFavourite"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["imageUrl"] = imageUrl;
    data["libraryTitle"] = libraryTitle;
    data["librarySubTitle"] = librarySubTitle;
    data["isFavourite"] = isFavourite;
    return data;
  }

  LibraryModel copyWith(LibraryModel libraryModel) {
    return LibraryModel(
      libraryTitle: libraryModel.libraryTitle ?? this.libraryTitle,
      librarySubTitle: libraryModel.librarySubTitle ?? this.librarySubTitle,
      imageUrl: libraryModel.imageUrl ?? this.imageUrl,
      isFavourite: libraryModel.isFavourite ?? this.isFavourite,
    );
  }
}
