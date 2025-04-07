part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class PhotoInitial extends PhotoState {}

class PhotoLoading extends PhotoState {}

class PhotoError extends PhotoState {
  final String message;
  const PhotoError(this.message);
  @override
  List<Object> get props => [message];
}

class PhotoSuccess extends PhotoState {
  final List<PhotoModel> photos;
  final List<PhotoModel>? filteredPhotos;

  const PhotoSuccess(this.photos, {this.filteredPhotos});

  @override
  List<Object> get props => [photos, filteredPhotos ?? []];
}
