import 'package:flutter/material.dart';

class BottomSheetWrapper extends StatelessWidget {
  final Widget child;
  final bool isScrollControlled;
  final bool enableDrag;

  const BottomSheetWrapper({
    super.key,
    required this.child,
    this.isScrollControlled = true,
    this.enableDrag = true,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding:const  EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
