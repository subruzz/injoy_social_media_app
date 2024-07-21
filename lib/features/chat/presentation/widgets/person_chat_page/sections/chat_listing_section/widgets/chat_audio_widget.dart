import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/chat/presentation/cubits/message_attribute/message_attribute_bloc.dart';

class ChatAudioWidget extends StatelessWidget {
  final String audioUrl;

  const ChatAudioWidget({super.key, required this.audioUrl});

  @override
  Widget build(BuildContext context) {
    log(audioUrl);
    return BlocBuilder<MessageAttributeBloc, MessageAttributeState>(
      builder: (context, state) {
        final bloc = context.read<MessageAttributeBloc>();
        final audioState = context.read<MessageAttributeBloc>().state;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              constraints: const BoxConstraints(minWidth: 50),
              onPressed: () {
                if (audioState is AudioState) {
                  if (audioState.url == audioUrl && audioState.isPlaying) {
                    bloc.add(PauseAudio(url: audioUrl));
                  } else {
                    bloc.add(PlayAudio(url: audioUrl));
                  }
                } else {
                  bloc.add(PlayAudio(url: audioUrl));
                }
              },
              icon: Icon(
                // audioState?.url == audioUrl
                //     ? (audioState!.isPlaying
                //         ? Icons.pause_circle
                //         : Icons.play_circle)
                //     : 
                    Icons.play_circle,
                size: 30,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    // StreamBuilder<Duration>(
                    //   stream: bloc.getAudioPlayer(audioUrl)?.positionStream,
                    //   builder: (context, snapshot) {
                    //     final audioPlayer = bloc.getAudioPlayer(audioUrl);
                    //     final duration = audioPlayer?.duration;
                    //     final position = snapshot.data ?? Duration.zero;
                    //     final isDurationAvailable = duration != null;

                    //     return Column(
                    //       children: [
                    //         Container(
                    //           margin: const EdgeInsets.only(top: 20),
                    //           width: double.infinity,
                    //           height: 2,
                    //           child: LinearProgressIndicator(
                    //             value: isDurationAvailable
                    //                 ? position.inMilliseconds.toDouble() /
                    //                     duration!.inMilliseconds.toDouble()
                    //                 : 0,
                    //             valueColor: const AlwaysStoppedAnimation<Color>(
                    //                 Colors.white),
                    //             backgroundColor: Colors.grey,
                    //           ),
                    //         ),
                    //         const SizedBox(height: 5),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               _formatDuration(position),
                    //               style: const TextStyle(color: Colors.white),
                    //             ),
                    //             Text(
                    //               isDurationAvailable
                    //                   ? _formatDuration(duration)
                    //                   : '00:00',
                    //               style: const TextStyle(color: Colors.white),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // )
                  // else
                  //   Container(
                  //     margin: const EdgeInsets.only(top: 20),
                  //     width: double.infinity,
                  //     height: 2,
                  //     child: const LinearProgressIndicator(
                  //       value: 0,
                  //       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  //       backgroundColor: Colors.grey,
                  //     ),
                  //   ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
