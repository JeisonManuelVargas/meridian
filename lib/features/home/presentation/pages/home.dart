import 'package:flutter/material.dart';
import 'package:meridian/features/home/presentation/widget/custom_list_view.dart';
import 'package:meridian/features/home/presentation/widget/header_custom.dart';
import 'package:meridian/features/home/presentation/widget/loading_page.dart';
import 'package:meridian/injection_container.dart';
import 'package:meridian/core/base/base_page.dart';
import 'package:meridian/features/home/presentation/cubit/home_cubit.dart';

class Home extends BasePage<HomeState, HomeCubit> {
  const Home({super.key});

  @override
  HomeCubit createBloc(BuildContext context) => sl<HomeCubit>()..init(context);

  @override
  Widget buildPage(BuildContext context, state, bloc) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: HeaderCustom(
                  title: "Welcome",
                  subTitle: "Jeison Manuel Vargas",
                  onTap: bloc.changeListView,
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 3,
                child: LoadingPage(
                  isLoading: state.isLoading,
                  child: PageView(
                    controller: state.pageController,
                    children: [
                      CustomListView(
                        key: state.listCoinKey,
                        onTapCard: bloc.onTapCard,
                        listMovie: state.movieList,
                        onTapButton: bloc.onTapButton,
                        controller: state.scrollController,
                        isFavorite: bloc.validateIsFavorite,
                      ),
                      CustomListView(
                        onTapCard: bloc.onTapCard,
                        onTapButton: bloc.onTapButton,
                        listMovie: state.movieListFavorite,
                        isFavorite: bloc.validateIsFavorite,
                        controller: state.scrollControllerFavorite,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
