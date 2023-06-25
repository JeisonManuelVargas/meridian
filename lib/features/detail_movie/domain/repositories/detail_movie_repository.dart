import 'package:dartz/dartz.dart';
import 'package:meridian/core/errors/failure.dart';
import 'package:meridian/core/model/genres_model.dart';

abstract class DetailMovieRepository {
  Future<Either<Failure, List<GenresModel>>> getListGenres();
}
