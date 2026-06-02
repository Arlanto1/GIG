
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideo extends StatefulWidget {
  final String filePath;

  const ShowVideo({super.key, required this.filePath});

  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.filePath))
      ..setVolume(_volume)
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
        _controller.setVolume(_volume);
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: _isInitialized
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            const SizedBox(height: 12),

            // ── Play / Pause ──
            IconButton(
              iconSize: 48,
              color: Colors.white,
              icon: Icon(
                _controller.value.isPlaying
                    ? Icons.pause_circle
                    : Icons.play_circle,
              ),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
            ),

            // ── Progress Bar ──
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              colors: const VideoProgressColors(
                playedColor: Colors.blue,
                bufferedColor: Colors.grey,
              ),
            ),

            const SizedBox(height: 12),

            // ── Volume Control ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Mute / Low volume icon
                  IconButton(
                    icon: Icon(
                      _volume == 0
                          ? Icons.volume_off
                          : _volume < 0.5
                          ? Icons.volume_down
                          : Icons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        // Toggle mute
                        _volume = _volume == 0 ? 1.0 : 0.0;
                        _controller.setVolume(_volume);
                      });
                    },
                  ),

                  // Slider
                  Expanded(
                    child: Slider(
                      value: _volume,
                      min: 0.0,
                      max: 1.0,
                      activeColor: Colors.blue,
                      inactiveColor: Colors.grey,
                      onChanged: (value) {
                        setState(() {
                          _volume = value;
                          _controller.setVolume(_volume);
                        });
                      },
                    ),
                  ),

                  // Volume percentage label
                  Text(
                    '${(_volume * 100).toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
            : const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}