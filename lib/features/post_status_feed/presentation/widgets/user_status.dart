import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/create_status/presentation/pages/create_statsus_page.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/view_status/view_status_bloc.dart';
import 'package:social_media_app/view_status_page.dart';

class UserStatus extends StatefulWidget {
  const UserStatus({super.key});

  @override
  State<UserStatus> createState() => _UserStatusState();
}

class _UserStatusState extends State<UserStatus> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ViewStatusBloc>().add(ViewCurrentUserStatusEvent(
          uId: context.read<AppUserBloc>().appUser!.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final userData = context.read<AppUserBloc>().appUser!;
    return SizedBox(
      height: 110,
      child: BlocConsumer<ViewStatusBloc, ViewStatusState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is ViewStatusSuccess) {
            final statuses = state.statuses;
            print(state.statuses.length);
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [
                  //       if (index == 0) {
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      // onTap: () {
                      //   Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => const ViewStatusPage(),
                      //   ));
                      // },
                      child: Column(
                        children: [
                          Container(
                            width: 65,
                            height: 65.0,
                            decoration: BoxDecoration(
                              color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image: NetworkImage(
                                  userData.profilePic!,
                                ),
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
                          const Text('You')
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: statuses.length,
                        itemBuilder: (context, index) {
                          final userAttribute =
                              statuses[index].statusUserAttribute;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => ViewStatusPage(
                                        statusEntity:
                                            statuses[index].userStatus,
                                      ),
                                    ));
                                  },
                                  child: Container(
                                    width: 65,
                                    height: 65.0,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff7c94b6),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            userAttribute.profilePictureUrl!),
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
                                ),
                                Text(userAttribute.username)
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
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
          }
          return SizedBox();
        },
      ),
    );
  }
}
