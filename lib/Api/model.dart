class DogModel {
  String? sId;
  int? id;
  String? title;
  String? description;
  String? breed;
  String? imageUrl;
  String? origin;
  String? lifeSpan;
  int? iV;

  DogModel(
      {this.sId,
        this.id,
        this.title,
        this.description,
        this.breed,
        this.imageUrl,
        this.origin,
        this.lifeSpan,
        this.iV});

  DogModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    breed = json['breed'];
    imageUrl = json['image_url'];
    origin = json['origin'];
    lifeSpan = json['life_span'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['breed'] = this.breed;
    data['image_url'] = this.imageUrl;
    data['origin'] = this.origin;
    data['life_span'] = this.lifeSpan;
    data['__v'] = this.iV;
    return data;
  }
}
