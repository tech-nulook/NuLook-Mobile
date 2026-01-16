class FeelToday {
  final String? name;
  final String? description;
  final String? type;
  final String? image;
  final bool? active;
  final int? id;

  FeelToday({
    this.name,
    this.description,
    this.type,
    this.image,
    this.active,
    this.id,
  });

  factory FeelToday.fromJson(Map<String, dynamic> json) {
    return FeelToday(
      name: json['name'],
      description: json['description'],
      type: json['type'],
      image: json['image'],
      active: json['active'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'type': type,
    'image': image,
    'active': active,
    'id': id,
  };
}