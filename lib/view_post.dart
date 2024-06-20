import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ViewPost extends StatefulWidget {
  final PostEntity post;
  const ViewPost({super.key, required this.post});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                  ),
                  AppSizedBox.sizedBox5W,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.userFullName,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        '@${widget.post.username}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppDarkColor().primaryTextBlur),
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz_rounded))
                ],
              ),
              AppSizedBox.sizedBox10H,
              if (widget.post.description != null) Text(widget.post.description!),
              if (widget.post.hashtags.isNotEmpty) Text(widget.post.hashtags.join('#')),
              AppSizedBox.sizedBox10H,
              SizedBox(
                  width: double.infinity,
                  height: .5.sh,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.post.postImageUrl[0]!,
                      fit: BoxFit.cover,
                    ),
                  )),
              AppSizedBox.sizedBox10H,
              Text('21:31 .14 jun 24'),
              Row(
                children: [
                  _buildIconWithCount(Icons.favorite, 435, Colors.red),
                  AppSizedBox.sizedBox10W,
                  _buildIconWithCount(Icons.chat_bubble_outline, 89),
                  AppSizedBox.sizedBox10W,
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      size: 18,
                    ),
                    color: Colors.white, // White color for the share icon
                  ),
                ],
              ),
              const Divider(),
              AppSizedBox.sizedBox20H,
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                  ),
                  AppSizedBox.sizedBox5W,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'sarah_virsson',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        '@sarah',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppDarkColor().primaryTextBlur),
                      )
                    ],
                  )
                ],
              ),
              AppSizedBox.sizedBox5H,
              Text(
                  'how many paragraphs are enough, and how many are too many? For historical writing, there should be between four and six paragraphs in a two-page paper, or ..'),
              Row(
                children: [
                  _buildIconWithCount(Icons.favorite, 435, Colors.red),
                  AppSizedBox.sizedBox10W,
                  TextButton(onPressed: () {}, child: Text('Reply')),
                  AppSizedBox.sizedBox10W,
                  Text('5 hours ago')
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                  ),
                  AppSizedBox.sizedBox5W,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'sarah_virsson',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        '@sarah',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppDarkColor().primaryTextBlur),
                      )
                    ],
                  )
                ],
              ),
              AppSizedBox.sizedBox5H,
              Text(
                  'how many paragraphs are enough, and how many are too many? For historical writing, there should be between four and six paragraphs in a two-page paper, or ..'),
              Row(
                children: [
                  _buildIconWithCount(Icons.favorite, 435, Colors.red),
                  AppSizedBox.sizedBox10W,
                  TextButton(onPressed: () {}, child: Text('Reply')),
                  AppSizedBox.sizedBox10W,
                  Text('5 hours ago')
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildIconWithCount(IconData icon, int count, [Color? iconColor]) {
  return Row(
    children: [
      Icon(
        icon,
        size: 18,
        color: iconColor ?? Colors.white,
      ),
      const SizedBox(width: 5),
      Text(
        count.toString(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    ],
  );
}
