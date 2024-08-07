import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ChatAudioWidget extends StatefulWidget {
  final String? audioUrl;
  const ChatAudioWidget({super.key, this.audioUrl});

  @override
  State<ChatAudioWidget> createState() => _ChatAudioWidgetState();
}

class _ChatAudioWidgetState extends State<ChatAudioWidget> {
  bool isPlaying = false;
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration? duration;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    audioPlayer.durationStream.listen((d) {
      setState(() {
        duration = d;
      });
    });

    audioPlayer.positionStream.listen((p) {
      setState(() {
        position = p;
      });
    });

    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          isPlaying = false;
          position = Duration.zero;
        });
        audioPlayer.stop();
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final totalDuration = duration ?? Duration.zero;
    final maxDuration = totalDuration.inMilliseconds.toDouble();
    final currentPosition = position.inMilliseconds.toDouble();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () async {
            if (isPlaying) {
              await audioPlayer.pause();
              setState(() {
                isPlaying = false;
              });
            } else {
              await audioPlayer.setUrl(widget.audioUrl!).then((_) async {
                setState(() {
                  isPlaying = true;
                });
                await audioPlayer.play();
              });
            }
          },
          icon: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 7),
                ),
                child: Slider(
                  min: 0.0,
                  max: maxDuration > 0 ? maxDuration : 1.0,
                  value: currentPosition <= maxDuration
                      ? currentPosition
                      : maxDuration,
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  onChanged: (value) {
                    audioPlayer.seek(Duration(milliseconds: value.toInt()));
                  },
                  // Reduced the slider height
                  thumbColor: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isPlaying
                        ? _formatDuration(position)
                        : _formatDuration(totalDuration),
                    style: const TextStyle(color: Colors.white),
                  ),
                  // Removed the total duration text on the right side
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
