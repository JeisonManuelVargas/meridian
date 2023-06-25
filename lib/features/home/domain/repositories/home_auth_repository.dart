import 'package:dartz/dartz.dart';
import 'package:meridian/core/errors/failure.dart';
import 'package:meridian/core/model/movie_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<MovieModel>>> getListMovie();
}
