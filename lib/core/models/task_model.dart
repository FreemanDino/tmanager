class TaskModel {
  String? id;
  String title;
  String description;

  TaskModel({
    required this.title,
    required this.description,
    this.id,
  });

  factory TaskModel.empty() => TaskModel(title: '', description: '');

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
