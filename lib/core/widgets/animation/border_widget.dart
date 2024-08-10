import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';

class StatusDottedBordersWidget extends CustomPainter {
  //number of stories
  final int numberOfStories;

  //length of the space arc (empty one)
  final int spaceLength;
  final String? uid;
  final List<SingleStatusEntity>? images;
  final bool isMe;
  final bool isLoading;
  //start of the arc painting in degree(0-360)
  double startOfArcInDegree = 0;

  StatusDottedBordersWidget(
      {required this.numberOfStories,
      this.spaceLength = 10,
      this.isLoading = false,
      this.uid,
      this.images,
      required this.isMe});

  //drawArc deals with rads, easier for me to use degrees
  //so this takes a degree and change it to rad
  double inRads(double degree) {
    return (degree * pi) / 180;
  }

  @override
  bool shouldRepaint(StatusDottedBordersWidget oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (numberOfStories <= 0) return;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    if (numberOfStories <= 1 || isMe) {
      // Draw a full circle if there's only 1 story
      canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        min(size.width / 2, size.height / 2),
        Paint()
          ..color = isMe
              ? images!.isEmpty
                  ? greyColor
                  : tabColor
              : images![0].viewers.contains(uid)
                  ? greyColor.withOpacity(.5)
                  : tabColor
          ..strokeWidth = 6
          ..style = PaintingStyle.stroke,
      );
    } else {
      //circle angle is 360, remove all space arcs between the main story arc (the number of spaces(stories) times the  space length
      //then subtract the number from 360 to get ALL arcs length
      //then divide the ALL arcs length by number of Arc (number of stories) to get the exact length of one arc
      double arcLength =
          (360 - (numberOfStories * spaceLength)) / numberOfStories;

      //be careful here when arc is a negative number
      //that happens when the number of spaces is more than 360
      //feel free to use what logic you want to take care of that
      //note that numberOfStories should be limited too here
      if (arcLength <= 0) {
        arcLength = 360 / spaceLength - 1;
      }

      //looping for number of stories to draw every story arc
      for (int i = 0; i < numberOfStories; i++) {
        //printing the arc
        canvas.drawArc(
          rect,
          inRads(startOfArcInDegree),
          //be careful here is:  "double sweepAngle", not "end"
          inRads(isLoading ? 0 : arcLength),
          false,
          Paint()
            //here you can compare your SEEN story index with the arc index to make it grey
            ..color = isMe
                ? tabColor
                : images![i].viewers.contains(uid)
                    ? greyColor.withOpacity(.6)
                    : tabColor
            ..strokeWidth = 6
            ..style = PaintingStyle.stroke,
        );

        //the logic of spaces between the arcs is to start the next arc after jumping the length of space
        startOfArcInDegree += arcLength + spaceLength;
      }
    }
  }
}

const greyColor = Colors.grey;
const tabColor = Color(0xFFef5c76);
