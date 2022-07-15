class Task{
  final int id;
  final String title;
  final String? subtitle;

  const Task({required this.id,required this.title,required this.subtitle});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, title: $title, subtitle: $subtitle}';
  }
}