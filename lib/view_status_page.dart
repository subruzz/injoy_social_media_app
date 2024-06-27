// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:story_view/controller/story_controller.dart';
// import 'package:story_view/widgets/story_view.dart';

// import 'package:social_media_app/core/common/entities/status_entity.dart';
// import 'package:social_media_app/features/post_status_feed/presentation/bloc/view_status/view_status_bloc.dart';

// class ViewStatusPage extends StatefulWidget {
//   const ViewStatusPage({
//     super.key,
//     required this.statusEntity,
//   });
//   final List<StatusEntity> statusEntity;
//   @override
//   State createState() => _MoreStoriesState();
// }

// class _MoreStoriesState extends State<ViewStatusPage> {
//   final storyController = StoryController();

//   @override
//   void dispose() {
//     storyController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: StoryView(
//       storyItems: [
//         ...widget.statusEntity.map(
//           (e) => StoryItem.text(
//             textStyle: const TextStyle(
//                 fontWeight: FontWeight.bold, color: Colors.white),
//             title: e.content ?? '',
//             backgroundColor: Color(e.color),
//           ),
//         )
//       ],
//       onStoryShow: (storyItem, index) {
//         print("Showing a story");
//       },
//       onComplete: () {
//         Navigator.pop(context);
//         print("Completed a cycle");
//       },
//       progressPosition: ProgressPosition.top,
//       repeat: false,
//       controller: storyController,
//     ));
//   }
// }
