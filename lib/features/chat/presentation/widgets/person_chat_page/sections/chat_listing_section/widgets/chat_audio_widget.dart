
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
  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          constraints: const BoxConstraints(minWidth: 50),
          onPressed: () async {
            if (isPlaying) {
              await audioPlayer.pause();
              setState(() {
                isPlaying = false;
              });
            } else {
              await audioPlayer.setUrl(widget.audioUrl!).then((value) async {
                setState(() {
                  isPlaying = true;
                });
                await audioPlayer.play().then((value) async {
                  setState(() {
                    isPlaying = false;
                  });
                  await audioPlayer.stop();
                });
              });
            }
          },
          icon: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            size: 30,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        isPlaying
            ? StreamBuilder<Duration>(
                stream: audioPlayer.positionStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 190,
                      height: 2,
                      child: LinearProgressIndicator(
                        value: snapshot.data!.inMilliseconds.toDouble() /
                            audioPlayer.duration!.inMilliseconds.toDouble(),
                        valueColor:
                            const AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Colors.white,
                      ),
                    );
                  } else {
                    return Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 190,
                      height: 2,
                      child: const LinearProgressIndicator(
                        value: 0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: Colors.white,
                      ),
                    );
                  }
                })
            : Container(
                margin: const EdgeInsets.only(top: 20),
                width: 190,
                height: 2,
                child: const LinearProgressIndicator(
                  value: 0,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  backgroundColor: Colors.white,
                ),
              ),
      ],
    );
  }
}
