part of 'photo_bloc.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();

  @override
  List<Object> get props => [];
}

class GetPhotosEvent extends PhotoEvent {
  const GetPhotosEvent();
}

class SearchPhotosEvent extends PhotoEvent {
  final String query;
  final String? orientation;
  final String? size;
  final String? color;

  const SearchPhotosEvent({
    required this.query,
    this.orientation,
    this.size,
    this.color,
  });

  @override
  List<Object> get props => [query, orientation ?? '', size ?? '', color ?? ''];
}


class FilterPhotosEvent extends PhotoEvent {
  final String? orientation;
  final String? size;
  final String? color;

  const FilterPhotosEvent({this.orientation, this.size, this.color});
}
