class Task {
  String title;
  String description;
  bool isCompleted;
  String category;

  Task({
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.category = 'Personal',
  });

  void toggleCompletion() {
    isCompleted = !isCompleted;
  }
}
