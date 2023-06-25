import 'package:dartz/dartz.dart';
import 'package:meridian/core/errors/failure.dart';
import 'package:meridian/core/errors/exceptions.dart';
import 'package:meridian/core/model/movie_model.dart';
import 'package:meridian/features/home/data/data_sources/home_data_source.dart';
import 'package:meridian/features/home/domain/repositories/home_auth_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({required this.homeDataSource});

  final HomeDataSource homeDataSource;

  @override
  Future<Either<Failure, List<MovieModel>>> getListMovie() async {
    try {
      final result = await homeDataSource.getListMovies();
      return Right(result);
    } on HomeException catch (e) {
      return Left(HomeFailure(code: e.code));
    }
  }
}
