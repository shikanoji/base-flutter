import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  const HomeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, createdAt];
}
