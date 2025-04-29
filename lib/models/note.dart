import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime createdAt;
  final bool isPinned;

  Note({
    String? id,
    required this.title,
    required this.content,
    required this.category,
    DateTime? createdAt,
    this.isPinned = false,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Note copyWith({
    String? title,
    String? content,
    String? category,
    bool? isPinned,
  }) {
    return Note(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      createdAt: createdAt,
      isPinned: isPinned ?? this.isPinned,
    );
  }

  @override
  List<Object?> get props => [id, title, content, category, createdAt, isPinned];
} 