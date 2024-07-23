// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/features/call/domain/usecases/get_channel_id.dart';
// import 'package:social_media_app/features/call/presentation/call/call_cubit.dart';
// import 'package:social_media_app/features/call/presentation/pages/call_page.dart';
// import 'package:social_media_app/init_dependecies.dart';

// class PickUpCallPage extends StatefulWidget {
//   final String? uid;
//   final Widget child;

//   const PickUpCallPage({super.key, required this.child, this.uid});

//   @override
//   State<PickUpCallPage> createState() => _PickUpCallPageState();
// }

// class _PickUpCallPageState extends State<PickUpCallPage> {
//   @override
//   void initState() {
//     BlocProvider.of<CallCubit>(context).getUserCalling(widget.uid!);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CallCubit, CallState>(
//       builder: (context, callState) {
//         if (callState is CallDialed) {
//           final call = callState.userCall;

//           if (call?.isCallDialed == false) {
//             return Scaffold(
//               body: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 40),
//                   const Text(
//                     'Incoming Call',
//                     style: TextStyle(
//                       fontSize: 30,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                   // profileWidget(imageUrl: call.receiverProfileUrl),
//                   const SizedBox(height: 40),
//                   Text(
//                     "${call?.receiverName}",
//                     style: const TextStyle(
//                       fontSize: 25,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w900,
//                     ),
//                   ),
//                   const SizedBox(height: 50),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         onPressed: () async {
//                           // BlocProvider.of<AgoraCubit>(context)
//                           //     .leaveChannel()
//                           //     .then((value) {
//                           //   BlocProvider.of<CallCubit>(context)
//                           //       .updateCallHistoryStatus(CallEntity(
//                           //           callId: call.callId,
//                           //           callerId: call.callerId,
//                           //           receiverId: call.receiverId,
//                           //           isCallDialed: false,
//                           //           isMissed: true))
//                           //       .then((value) {
//                           //     BlocProvider.of<CallCubit>(context).endCall();
//                           //   });
//                           // });
//                         },
//                         icon:
//                             const Icon(Icons.call_end, color: Colors.redAccent),
//                       ),
//                       const SizedBox(width: 25),
//                       IconButton(
//                         onPressed: () async {
//                           final res =
//                               await serviceLocator<GetAllChannelIdUseCase>()
//                                   .call(GetAllChannelIdUseCaseParams(
//                                       uid: call!.receiverId!));

//                           res.fold((failure) {}, (sucess) {
//                             Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) => CallPage(callId: sucess),
//                             ));
//                           });

//                           // di.sl<GetCallChannelIdUseCase>().call(call.receiverId!).then((callChannelId) {

//                           //   Navigator.pushNamed(context, PageConst.callPage, arguments: CallEntity(
//                           //       callId: callChannelId,
//                           //       callerId: call.callerId!,
//                           //       receiverId: call.receiverId!
//                           //   ));

//                           // print("callChannelId = $callChannelId");
//                           // });
//                         },
//                         icon: const Icon(
//                           Icons.call,
//                           color: Colors.green,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }
//           return widget.child;
//         }
//         return widget.child;
//       },
//     );
//   }
// }
