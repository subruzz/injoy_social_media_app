import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/create_post/features/pages/create_post_page.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: SpeedDial(
          overlayOpacity: .5,
          icon: Icons.add,
          activeIcon: Icons.close,
          children: [
            SpeedDialChild(child: const Icon(Icons.circle), label: 'Status'),
            SpeedDialChild(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CreatePostScreen(
                        locationBloc: GetIt.instance<LocationBloc>()),
                  ));
                },
                child: const Icon(Icons.add_to_photos_sharp),
                label: 'Post'),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'INJOY',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(letterSpacing: 5),
                    ),
                    const CircleAvatar(
                      radius: 23,
                      backgroundImage: NetworkImage(
                          'https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg'),
                    )
                  ],
                ),
              ),
              AppSizedBox.sizedBox10H,
              SizedBox(
                height: 110,
                child: ListView(
                  padding: EdgeInsets.only(left: 10),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    ...List.generate(10, (index) {
                      if (index == 0) {
                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                width: 65,
                                height: 65.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xff7c94b6),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREoRGyXmHy_6aIgXYqWHdOT3KjfmnuSyxypw&s',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Transform.translate(
                                    offset: const Offset(15, 15),
                                    child: IconButton(
                                      icon: const Icon(Icons.add_circle,
                                          color: Colors.white),
                                      onPressed: () {
                                        // Your onPressed code here
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Text('You')
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              width: 65,
                              height: 65.0,
                              decoration: BoxDecoration(
                                color: const Color(0xff7c94b6),
                                image: const DecorationImage(
                                  image: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREoRGyXmHy_6aIgXYqWHdOT3KjfmnuSyxypw&s',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 3.0,
                                ),
                              ),
                            ),
                            const Text('Dasha')
                          ],
                        ),
                      );
                    })
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'For you',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Follwing',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ),
              AppSizedBox.sizedBox10H,
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://imgv3.fotor.com/images/slider-image/A-clear-close-up-photo-of-a-woman.jpg',
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    AppSizedBox.sizedBox5W,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Maria Williams',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.sp),
                                  ),
                                  AppSizedBox.sizedBox5W,
                                  const Text(
                                    '•',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  AppSizedBox.sizedBox5W,
                                  Text(
                                    '@Maria',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 13.sp),
                                  ),
                                  const Text(
                                    '•',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  ),
                                  AppSizedBox.sizedBox5W,
                                  Text(
                                    '2h',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 13.sp),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.more_horiz_rounded,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                          Text('Just had the most delicious avocado toast',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                            '#foodie#healthy',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(fontSize: 13.sp, color: Colors.blue),
                          ),
                          AppSizedBox.sizedBox5H,
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREoRGyXmHy_6aIgXYqWHdOT3KjfmnuSyxypw&s',
                              height: 130.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          AppSizedBox.sizedBox5H,
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 150,
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppDarkColor()
                                    .softBackground, // Dark background color
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildIconWithCount(
                                      Icons.favorite, 435, Colors.red),
                                  _buildIconWithCount(
                                      Icons.chat_bubble_outline, 89),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.send,
                                      size: 18,
                                    ),
                                    color: Colors
                                        .white, // White color for the share icon
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
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
