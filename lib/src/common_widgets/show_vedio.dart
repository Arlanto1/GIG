// // import 'dart:convert';
// // import 'dart:developer';
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:video_player/video_player.dart';
// //
// // class ShowVideo extends StatefulWidget {
// //   const ShowVideo({
// //     super.key,
// //     required this.base64Content,
// //     required this.extension, // e.g. 'mp4'
// //     this.title = 'Video',
// //   });
// //
// //   final String base64Content;
// //   final String extension;
// //   final String title;
// //
// //   @override
// //   State<ShowVideo> createState() => _ShowVideoState();
// // }
// //
// // class _ShowVideoState extends State<ShowVideo> {
// //   VideoPlayerController? _controller;
// //   bool _isInitialized = false;
// //   String? _error;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _initVideo();
// //   }
// //
// //   Future<void> _initVideo() async {
// //     try {
// //       // Decode base64 → write to temp file → play from file
// //       final bytes = base64Decode(widget.base64Content);
// //       final dir = await getTemporaryDirectory();
// //       final file = File('${dir.path}/video_temp.${widget.extension}');
// //       await file.writeAsBytes(bytes);
// //
// //       _controller = VideoPlayerController.file(file)
// //         ..initialize().then((_) {
// //           setState(() => _isInitialized = true);
// //           _controller!.play();
// //         });
// //     } catch (e) {
// //       log('ShowVideo init error: $e');
// //       setState(() => _error = 'Failed to load video');
// //     }
// //   }
// //
// //   @override
// //   void dispose() {
// //     _controller?.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       appBar: AppBar(
// //         backgroundColor: Colors.black,
// //         iconTheme: const IconThemeData(color: Colors.white),
// //         title: Text(widget.title,
// //             style: const TextStyle(color: Colors.white, fontSize: 16)),
// //       ),
// //       body: Center(
// //         child: _error != null
// //             ? Text(_error!, style: const TextStyle(color: Colors.white))
// //             : !_isInitialized
// //             ? const CircularProgressIndicator(color: Colors.white)
// //             : Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             AspectRatio(
// //               aspectRatio: _controller!.value.aspectRatio,
// //               child: VideoPlayer(_controller!),
// //             ),
// //             const SizedBox(height: 20),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 IconButton(
// //                   iconSize: 48,
// //                   icon: Icon(
// //                     _controller!.value.isPlaying
// //                         ? Icons.pause_circle_filled
// //                         : Icons.play_circle_filled,
// //                     color: Colors.white,
// //                   ),
// //                   onPressed: () {
// //                     setState(() {
// //                       _controller!.value.isPlaying
// //                           ? _controller!.pause()
// //                           : _controller!.play();
// //                     });
// //                   },
// //                 ),
// //               ],
// //             ),
// //             VideoProgressIndicator(
// //               _controller!,
// //               allowScrubbing: true,
// //               colors: const VideoProgressColors(
// //                 playedColor: Colors.white,
// //                 bufferedColor: Colors.grey,
// //                 backgroundColor: Colors.black45,
// //               ),
// //               padding: const EdgeInsets.symmetric(
// //                   horizontal: 24, vertical: 8),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // show_video.dart
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class ShowVideo extends StatefulWidget {
//   final String filePath;
//
//   const ShowVideo({super.key, required this.filePath});
//
//   @override
//   State<ShowVideo> createState() => _ShowVideoState();
// }
//
// class _ShowVideoState extends State<ShowVideo> {
//   late VideoPlayerController _controller;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.file(File(widget.filePath))
//       ..setVolume(9.0)
//       ..initialize().then((_) {
//         setState(() => _isInitialized = true);
//         _controller.setVolume(9.0);
//         _controller.play();
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Center(
//         child: _isInitialized
//             ? Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             ),
//             const SizedBox(height: 12),
//             IconButton(
//               iconSize: 48,
//               color: Colors.white,
//               icon: Icon(
//                 _controller.value.isPlaying
//                     ? Icons.pause_circle
//                     : Icons.play_circle,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _controller.value.isPlaying
//                       ? _controller.pause()
//                       : _controller.play();
//                 });
//               },
//             ),
//             VideoProgressIndicator(
//               _controller,
//               allowScrubbing: true,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               colors: const VideoProgressColors(
//                 playedColor: Colors.blue,
//                 bufferedColor: Colors.grey,
//               ),
//             ),
//           ],
//         )
//             : const CircularProgressIndicator(color: Colors.white),
//       ),
//     );
//   }
// }

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