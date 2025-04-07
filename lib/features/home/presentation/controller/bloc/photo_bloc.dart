import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/app_strings.dart';
import '../../../data/model/photo_model.dart';
import '../../../data/repository/home_repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final HomeRepository repository;
  int _page = 1;
  bool _isFetching = false;
  String? _currentQuery;

  PhotoBloc(this.repository) : super(PhotoInitial()) {
    on<GetPhotosEvent>(_onGetPhotos);
    on<SearchPhotosEvent>(_onSearchPhotos);
    on<FilterPhotosEvent>(_onFilterPhotos);
  }

  Future<void> _onGetPhotos(
    GetPhotosEvent event,
    Emitter<PhotoState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;

    if (state is PhotoInitial) {
      emit(PhotoLoading());
    }

    final result = await repository.getPhotos(_page);

    result.fold((failure) => emit(PhotoError(failure.message)), (photos) {
      _page++;
      final currentPhotos =
          state is PhotoSuccess
              ? (state as PhotoSuccess).photos
              : <PhotoModel>[];
      emit(PhotoSuccess([...currentPhotos, ...photos]));
    });

    _isFetching = false;
  }

  List<PhotoModel> filteredPhotos = [];
  Future<void> _onSearchPhotos(
    SearchPhotosEvent event,
    Emitter<PhotoState> emit,
  ) async {
    if (_isFetching) return;
    _isFetching = true;

    if (_currentQuery != event.query) {
      _page = 1;
      _currentQuery = event.query;
      emit(PhotoLoading());
    }

    final result = await repository.searchPhotos(
      _currentQuery!,
      _page,
      orientation: event.orientation,
      size: event.size,
      color: event.color,
    );

    result.fold((failure) => emit(PhotoError(failure.message)), (photos) {
      _page++;
      final currentPhotos =
          state is PhotoSuccess
              ? (state as PhotoSuccess).photos
              : <PhotoModel>[];

      emit(PhotoSuccess([...currentPhotos, ...photos]));
    });

    _isFetching = false;
  }

  void _onFilterPhotos(FilterPhotosEvent event, Emitter<PhotoState> emit) {
    if (state is PhotoSuccess) {
      final allPhotos = (state as PhotoSuccess).photos;

      final filtered =
          allPhotos.where((photo) {
            final matchOrientation =
                event.orientation == null ||
                _matchesOrientation(photo, event.orientation!);
            final matchSize =
                event.size == null || _matchesSize(photo, event.size!);
            final matchColor =
                event.color == null ||
                photo.avgColor.toLowerCase() == event.color!.toLowerCase();

            return matchOrientation && matchSize && matchColor;
          }).toList();

      emit(PhotoSuccess(allPhotos, filteredPhotos: filtered));
    }
  }

  bool _matchesOrientation(PhotoModel photo, String orientation) {
    if (orientation == AppStrings.portrait) return photo.height > photo.width;
    if (orientation == AppStrings.landscape) return photo.width > photo.height;
    if (orientation == AppStrings.square) return photo.width == photo.height;
    return true;
  }

  bool _matchesSize(PhotoModel photo, String size) {
    final totalPixels = photo.width * photo.height;
    switch (size) {
      case AppStrings.small:
        return totalPixels < 500000;
      case AppStrings.medium:
        return totalPixels >= 500000 && totalPixels < 1500000;
      case AppStrings.large:
        return totalPixels >= 1500000;
      default:
        return true;
    }
  }

  
}
