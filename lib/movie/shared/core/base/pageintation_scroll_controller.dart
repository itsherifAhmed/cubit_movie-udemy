import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class PaginationScrollController extends ScrollController {
  PaginationScrollController(Function pagination) {
    bool debounce = false;
    addListener(() async {
      if (!debounce) {
        if (position.maxScrollExtent <= position.pixels) {
          debounce = true;
          pagination();
          await futureDelayed(milliseconds: 500);
          debounce = false;
        }
      }
    });
  }
}