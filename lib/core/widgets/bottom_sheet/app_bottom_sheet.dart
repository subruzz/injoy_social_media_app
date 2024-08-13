import 'package:flutter/material.dart';

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;
  final bool isScrollControlled;
  final bool enableDrag;

  const BottomSheetWrapper({
    Key? key,
    required this.child,
    this.isScrollControlled = true,
    this.enableDrag = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
