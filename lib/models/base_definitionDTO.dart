class BaseDefinitionDTO {
  String id; // Dart doesn't have a direct equivalent to uint; int is typically used.
  String title;

  BaseDefinitionDTO({required this.id, required this.title});

  // Optional: Create a method to convert JSON to BaseDefinitionDTO
  factory BaseDefinitionDTO.fromJson(Map<String, dynamic> json) {
    return BaseDefinitionDTO(
      id: json['id'].toString(),
      title: json['title'],
    );
  }

  // Optional: Convert BaseDefinitionDTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}