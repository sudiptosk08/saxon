import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saxonmarket/controller/pagination/scroll_state.dart';

final productsByKeywordScrollProvider= StateNotifierProvider<ProductsByKeywordScrollProvider, ScrollState>((ref)=> ProductsByKeywordScrollProvider(ref:ref));


class ProductsByKeywordScrollProvider extends StateNotifier<ScrollState>{
  final Ref? ref;
  ProductsByKeywordScrollProvider({this.ref}) : super(ScrollInitialState());

  ScrollController _scrollController=ScrollController();
  //Offset state <-------------------------------------
  double offset = 0.0;
  get controller {
    offset = 0.0;
    _scrollController.addListener(scrollListener);
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