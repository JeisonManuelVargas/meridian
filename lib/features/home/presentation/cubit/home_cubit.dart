import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meridian/core/base/base_usecase.dart';
import 'package:meridian/core/model/movie_model.dart';
import 'package:meridian/core/navigation/navigator.dart';
import 'package:meridian/core/util/custom_snack_bar.dart';
import 'package:meridian/features/home/domain/usecases/get_coin_list_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetMovieListUseCase _getMovieListUseCase;

  HomeCubit({
    required GetMovieListUseCase getCoinListUseCase,
  })  : _getMovieListUseCase = getCoinListUseCase,
        super(HomeState.init());

  init(BuildContext context) {
    getMovieList(context: context);
  }

  getMovieList({required BuildContext context}) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getMovieListUseCase(NoParams());
    result.fold(
      (dynamic l) {
        emit(state.copyWith(isLoading: false));
        customSnackBar(context, content: l.code);
      },
      (r) async {
        emit(state.copyWith(
          movieList: r,
          isLoading: false,
          skip: state.limit,
          limit: state.limit + 10,
        ));
      },
    );
  }

  void changeListView(String key) {
    if (key == "All List") {
      state.pageController.animateToPage(
        0,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 400),
      );
    }
    if (key == "Favorite List") {
      state.pageController.animateToPage(
        1,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 400),
      );
    }
  }

  void onTapCard(MovieModel movie) {
    bool haveCoin = state.movieListFavorite.contains(movie);
    if (haveCoin) state.movieListFavorite.remove(movie);
    if (!haveCoin) state.movieListFavorite.add(movie);
    emit(state.copyWith());
  }

  void onTapButton(MovieModel movie) =>
      AppNavigator.push(Routes.DETAIL_MOVIE, arguments: movie);

  bool validateIsFavorite(MovieModel movie) =>
      state.movieListFavorite.contains(movie);
}
