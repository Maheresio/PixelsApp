import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../model/photo_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page);
  Future<Either<Failure, List<PhotoModel>>> searchPhotos(
    String query,
    int page, {
    String? orientation,
    String? size,
    String? color,
  });
}
