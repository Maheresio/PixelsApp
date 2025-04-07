import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pixels_app/core/error/failure.dart';
import 'package:pixels_app/features/home/data/model/photo_model.dart';
import 'package:pixels_app/features/home/data/repository/home_repository.dart';

import '../../../../core/api_constants.dart';
import '../../../../core/error/server_failure.dart';
import '../../../../core/services/api_service.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ApiService apiService;

  HomeRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<PhotoModel>>> getPhotos(int page) async {
    try {
      final url = ApiConstants.curatedPhotos(page);
      final data = await apiService.get(url: url);

      List photosData = data['photos'];
      List<PhotoModel> photos =
          photosData.map((json) => PhotoModel.fromJson(json)).toList();

      return Right(photos);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

 
  @override
Future<Either<Failure, List<PhotoModel>>> searchPhotos(
  String query,
  int page, {
  String? orientation,
  String? size,
  String? color,
}) async {
  try {
    final data = await apiService.searchPhotos(
      query: query,
      page: page,
      orientation: orientation,
      size: size,
      color: color,
    );

    List photosData = data['photos'];
    List<PhotoModel> photos =
        photosData.map((json) => PhotoModel.fromJson(json)).toList();

    return Right(photos);
  } on DioException catch (e) {
    return Left(ServerFailure.fromDioError(e));
  } catch (e) {
    return Left(ServerFailure(e.toString()));
  }
}

}
