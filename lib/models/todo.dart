class Todo {
  late int? id;
  late String title;
  late String description;

  Todo({
    this.id,
    required this.title,
    required this.description,
  });

  // 주고받는 양식은 Json -> Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Todo.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    title = map?['title'];
    description = map?['description'];
  }
}
