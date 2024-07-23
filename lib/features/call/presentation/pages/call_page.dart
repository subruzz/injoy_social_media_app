// import 'package:agora_uikit/agora_uikit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
// import 'package:social_media_app/features/call/presentation/agora/agora_cubit.dart';
// import 'package:social_media_app/features/call/presentation/call/call_cubit.dart';

// class CallPage extends StatefulWidget {
//   const CallPage({super.key, required this.callId});
//   final String callId;

//   @override
//   State<CallPage> createState() => _CallPageState();
// }

// class _CallPageState extends State<CallPage> {
//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<AgoraCubit>()
//         .initialize(channelName: widget.callId, tokenUrl: '');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final agora = context.read<AgoraCubit>();
//     return Scaffold(
//       body: agora.getAgoraClient == null
//           ? const Center(child: CircularLoadingGrey())
//           : SafeArea(
//               child: Stack(
//                 children: [
//                   AgoraVideoViewer(client: agora.getAgoraClient!),
//                   AgoraVideoButtons(
//                     client: agora.getAgoraClient!,
//                     disconnectButtonChild: IconButton(
//                       color: Colors.red,
//                       onPressed: () async {
//                         await agora.leaveChannel().then((value) {
//                           BlocProvider.of<CallCubit>(context).endCall();
//                         });
//                         if (context.mounted) Navigator.pop(context);
//                       },
//                       icon: const Icon(Icons.call_end),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
