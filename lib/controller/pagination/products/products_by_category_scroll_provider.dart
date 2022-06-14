import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/pagination/scroll_state.dart';

final productsByCategoryScrollProvider =
    StateNotifierProvider<ProductsByCategoryScrollProvider, ScrollState>((ref) => ProductsByCategoryScrollProvider(ref: ref));

class ProductsByCategoryScrollProvider extends StateNotifier<ScrollState>{
  final Ref? ref;

  ProductsByCategoryScrollProvider({this.ref}) : super(ScrollInitialState());

ScrollController _scrollController = ScrollController();
  //Offset state <-------------------------------------
  double offset = 0.0;

  get controller {
    offset = 0.0;
    _scrollController.addListener(scrollListener);
    // _scrollController = ScrollController() //keepScrollOffset: false removed
    //   ..addListener(() {
    //     offset = _scrollController.offset;
    //   });
    return _scrollController;
  }

  set setController(ScrollController scrollController) {
    _scrollController = scrollController;
  }

  get scrollNotifierState => state;

  scrollListener() {
    offset = _scrollController.offset;
    if (offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      state = ScrollReachedBottomState();
    }
  }

  resetState() {
    state = ScrollInitialState();
  }


}