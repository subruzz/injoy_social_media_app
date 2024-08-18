import 'package:flutter/material.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';

import '../../../../core/const/app_config/web_design_const.dart';
import '../../../../core/utils/responsive/responsive_helper.dart';

class VideosPageWeb extends StatefulWidget {
  const VideosPageWeb({super.key});

  @override
  State<VideosPageWeb> createState() => _VideosPageWebState();
}

class _VideosPageWebState extends State<VideosPageWeb> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Flexible(
            flex: 3,
            child: SizedBox(child: VideoReelPage()),
          ),
          // Flexible(
          //     flex: 4,
          //     child: Container(
          //         width: double.infinity,
          //         decoration: const BoxDecoration(
          //           border: Border(
          //             left: BorderSide(
          //               color: borderColor,
          //               width: 2.0, // Adjust the width as needed
          //             ),
          //           ),
          //         ),
          //         child: Container(
                  
          //           height: MediaQuery.of(context).size.height,
          //           color: Colors.green,
          //         ))),
        ],
      ),
    );
  }
}
