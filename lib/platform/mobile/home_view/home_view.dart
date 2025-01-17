import 'package:everydaybible/platform/mobile/bible_view/bible_view.dart';
import 'package:everydaybible/platform/mobile/home_view/bloc/home_bloc.dart';
import 'package:everydaybible/platform/mobile/quite_time_dash_board_view/quite_time_dash_board_view.dart';
import 'package:everydaybible/platform/mobile/setting_view/setting_view.dart';
import 'package:everydaybible/widgets/bible_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeBloc get bloc => BlocProvider.of(context);

  @override
  void initState() {
    super.initState();
    bloc.add(HomeEventInited());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final status = state.status;
        switch (status) {
          case HomeViewStatus.init:
            return const BibleLoading();
          case HomeViewStatus.loading:
          case HomeViewStatus.failure:
          case HomeViewStatus.success:
        }
        final currentIndex = state.menuIndex;
        return Scaffold(
          body: PageView(
            key: ValueKey(currentIndex),
            physics: const NeverScrollableScrollPhysics(),
            controller: PageController(initialPage: currentIndex),
            children: const [
              BibleView(),
              QuiteTimeDashBoardView(),
              SettingView(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: currentIndex,
            onDestinationSelected: (index) {
              bloc.add(
                HomeEventUpdatedIndex(index),
              );
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.book),
                label: "Bible",
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark),
                label: "QuiteTime",
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: "Setting",
              ),
            ],
          ),
        );
      },
    );
  }
}
