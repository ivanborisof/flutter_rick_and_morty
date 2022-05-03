import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_and_morty/bloc/character_block.dart';
import 'package:flutter_rick_and_morty/bloc/character_event.dart';
import 'package:flutter_rick_and_morty/bloc/character_state.dart';
import 'package:flutter_rick_and_morty/data/models/character.dart';
import 'package:flutter_rick_and_morty/data/repositories/character_repo.dart';
import 'package:flutter_rick_and_morty/ui/widgets/card.dart';
import 'package:flutter_rick_and_morty/ui/widgets/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentPage = 1;
  bool _isPagination = false;
  List<Charter> _currentResults = [];
  final RefreshController refreshController = RefreshController();

  onChange(String value) {
    if (value == "") {
      _currentResults = [];
      _currentPage = 1;
      context.read<CharacterBlock>().add(FetchData());
    } else {
      context.read<CharacterBlock>().add(FetchData(name: value));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: const Size(428, 926),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                SearchWidget(
                  onChange: (value) {
                    EasyDebounce.debounce(
                        'my-debouncer',
                        const Duration(milliseconds: 400),
                        () => onChange(value));
                  },
                ),
                SizedBox(height: 20.h),
                BlocBuilder<CharacterBlock, CharacterState>(
                    builder: (context, state) {
                  if (state is Loading) {
                    if (_isPagination) {
                      return _customListView(_currentResults);
                    } else {
                      return Column(children: [
                        SizedBox(height: 150.h),
                        Image.asset(
                          "assets/rick_loading.gif",
                          height: 300.h,
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "Loading...",
                          style: TextStyle(
                            fontSize: 35.sp,
                          ),
                        )
                      ]);
                    }
                  } else if (state is Loaded) {
                    _currentResults.addAll(state.arrayOfCharacters);
                    refreshController.loadComplete();

                    return _customListView(_currentResults);
                  } else if (state is SearchLoaded) {
                    return _customSearchListView(state.arrayOfCharacters);
                  } else {
                    return Column(
                      children: [
                        SizedBox(height: 60.h),
                        Image.asset(
                          "assets/rick_error.gif",
                          height: 500.h,
                        ),
                        SizedBox(height: 80.h),
                        Text(
                          "Something went wrong",
                          style: TextStyle(
                            fontSize: 35.sp,
                          ),
                        )
                      ],
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customListView(currentResults) {
    return SizedBox(
      height: 800.h,
      child: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: false,
        onLoading: () async {
          if (_currentPage < await CharterRepo().getNumberOfPages()) {
            _isPagination = true;
            _currentPage++;
            context.read<CharacterBlock>().add(FetchData(
                pageId: _currentPage, pastCharacters: currentResults));
          } else {
            refreshController.loadNoData();
          }
        },
        child: ListView(
            children: currentResults
                .map<Widget>(
                  (e) => Column(
                    children: [
                      CardWidget(
                        charter: e,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                )
                .toList()),
      ),
    );
  }

  Widget _customSearchListView(currentResults) {
    return SizedBox(
      height: 800.h,
      child: ListView(
          children: currentResults
              .map<Widget>(
                (e) => Column(
                  children: [
                    CardWidget(
                      charter: e,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              )
              .toList()),
    );
  }
}
