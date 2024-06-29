import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/border_widget.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import 'package:social_media_app/features/create_status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'package:social_media_app/features/create_status/presentation/pages/create_statsus_page.dart';
import 'package:social_media_app/view_status_page.dart';

class UserStatus extends StatelessWidget {
  const UserStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = context.read<AppUserBloc>().appUser!;
    return SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //       if (index == 0) {
              BlocBuilder<GetMyStatusBloc, GetMyStatusState>(
                  builder: (context, state) {
                if (state is GetMyStatusSuccess) {
                  print('users bitches are here');
                  print(state.myStatus);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewStatusPage(
                            statusEntity: state.myStatus!,
                            index: 0,
                          ),
                        ));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 65,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: userData.profilePic != null
                                    ? NetworkImage(
                                        userData.profilePic!,
                                      )
                                    : const AssetImage(
                                        'assets/images/profile_icon.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                            ),
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Transform.translate(
                                offset: const Offset(15, 15),
                                child: IconButton(
                                  icon: const Icon(Icons.add_circle,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          const StatusCreationPage(),
                                    ));
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const StatusCreationPage(),
                    ));
                  },
                );
              }),
              BlocBuilder<GetAllStatusBloc, GetAllStatusState>(
                builder: (context, state) {
                  if (state is GetAllStatusSuccess) {
                    print('mama mia');
                    print('we have this much shits ${state.allStatus.length}');
                    return Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.allStatus.length,
                          itemBuilder: (context, index) {
                            final userAttribute = state.allStatus[index];
                            return GestureDetector(
                              onTap: () {
                                //       GestureDetector(
                                //         onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ViewStatusPage(
                                    index: 0,
                                    statusEntity: userAttribute,
                                  ),
                                ));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: SizedBox(
                                  width: 65,
                                  height: 65,
                                  child: Column(
                                    children: [
                                      CustomPaint(
                                        painter: StatusDottedBordersWidget(
                                            numberOfStories:
                                                userAttribute.statuses.length,
                                            isMe: false,
                                            spaceLength: 6,
                                            images: userAttribute.statuses,
                                            uid: context
                                                .read<AppUserBloc>()
                                                .appUser!
                                                .id),
                                        child: Container(
                                          margin: const EdgeInsets.all(3),
                                          width: 55,
                                          height: 55,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.asset(
                                                  'assets/images/profile_icon.png')),
                                        ),
                                      ),
                                      Text(userAttribute.userName)
                                    ],
                                  ),
                                ),
                              ),
                            );

                            //  Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Column(
                            //     children: [
                            //       GestureDetector(
                            //         onTap: () {
                            //           Navigator.of(context)
                            //               .push(MaterialPageRoute(
                            //             builder: (context) => ViewStatusPage(
                            //               index: 0,
                            //               statusEntity: userAttribute,
                            //             ),
                            //           ));
                            //         },
                            //         child: Container(
                            //           width: 65,
                            //           height: 65.0,
                            //           decoration: BoxDecoration(
                            //             color: const Color(0xff7c94b6),
                            //             image: DecorationImage(
                            //               image: state.allStatus[index]
                            //                           .profilePic !=
                            //                       null
                            //                   ? NetworkImage(
                            //                       state.allStatus[index]
                            //                           .profilePic!,
                            //                     )
                            //                   : const AssetImage(
                            //                       'assets/images/profile_icon.png'),
                            //               fit: BoxFit.cover,
                            //             ),
                            //             borderRadius: const BorderRadius.all(
                            //                 Radius.circular(50.0)),
                            //             border: Border.all(
                            //               color: Colors.red,
                            //               width: 3.0,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Text(userAttribute.userName)
                            //     ],
                            //   ),
                            // );
                          }),
                    );
                  }
                  return SizedBox();
                },
              )
            ],
          ),
        )
        // return
        // ListView(
        //     padding: const EdgeInsets.only(left: 10),
        //     shrinkWrap: true,
        //     scrollDirection: Axis.horizontal,
        //     children: []

        //     ...List.generate(10, (index) {
        //       if (index == 0) {
        //         return Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: GestureDetector(
        //             onTap: () {
        //               Navigator.of(context).push(MaterialPageRoute(
        //                 builder: (context) => const ViewStatusPage(),
        //               ));
        //             },
        //             child: Column(
        //               children: [
        //                 Container(
        //                   width: 65,
        //                   height: 65.0,
        //                   decoration: BoxDecoration(
        //                     color: const Color(0xff7c94b6),
        //                     image: DecorationImage(
        //                       image: NetworkImage(
        //                         userData.profilePic!,
        //                       ),
        //                       fit: BoxFit.cover,
        //                     ),
        //                     borderRadius: const BorderRadius.all(
        //                         Radius.circular(50.0)),
        //                   ),
        //                   child: Align(
        //                     alignment: Alignment.bottomRight,
        //                     child: Transform.translate(
        //                       offset: const Offset(15, 15),
        //                       child: IconButton(
        //                         icon: const Icon(Icons.add_circle,
        //                             color: Colors.white),
        //                         onPressed: () {
        //                           Navigator.of(context)
        //                               .push(MaterialPageRoute(
        //                             builder: (context) =>
        //                                 const StatusCreationPage(),
        //                           ));
        //                         },
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //                 const Text('You')
        //               ],
        //             ),
        //           ),
        //         );
        //       }
        //       return Padding(
        //         padding: const EdgeInsets.all(8.0),
        //         child: Column(
        //           children: [
        //             Container(
        //               width: 65,
        //               height: 65.0,
        //               decoration: BoxDecoration(
        //                 color: const Color(0xff7c94b6),
        //                 image: const DecorationImage(
        //                   image: NetworkImage(
        //                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREoRGyXmHy_6aIgXYqWHdOT3KjfmnuSyxypw&s',
        //                   ),
        //                   fit: BoxFit.cover,
        //                 ),
        //                 borderRadius:
        //                     const BorderRadius.all(Radius.circular(50.0)),
        //                 border: Border.all(
        //                   color: Colors.red,
        //                   width: 3.0,
        //                 ),
        //               ),
        //             ),
        //             const Text('Dasha')
        //           ],
        //         ),
        //       );
        //     })
        //   ],
        // );
        // );

        );
  }
}
