/*
Date: 2024.09.03
Producer: Se Jun Lim
Email: lsj1137jsl@gmail.com
ReadMe: 
This document is about audio player function.
Dependency documents:
https://pub.dev/packages/file_picker
https://pub.dev/packages/audioplayers
*/

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';


final AudioPlayer _audioPlayer = AudioPlayer();
bool _isPlaying = false;
bool _fileReady = false;
Duration _duration = Duration.zero;
Duration _position = Duration.zero;
String _localFilePath = '';



@override
void initState() {
  super.initState();
  _audioPlayer.onDurationChanged.listen((Duration d) {
    setState(() => _duration = d);
  });
  _audioPlayer.onPositionChanged.listen((Duration p) {
    setState(() => _position = p);
  });
}



@override
void dispose() {
  _audioPlayer.dispose();
  super.dispose();
}



// pick file to play
Future<void> _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.audio,
  );

  if (result != null && result.files.single.path != null) {
    setState(() {
      _localFilePath = result.files.single.path!;
      _audioPlayer.setSource(DeviceFileSource(_localFilePath));
      _audioPlayer.stop();
      _fileReady = true;
    });
  }
}

// play or pause media
void _playPause() {
  if (!_fileReady) {
    return;
  }
  if (_isPlaying) {
    _audioPlayer.pause();
  } else {
    _audioPlayer.play(DeviceFileSource(_localFilePath));
    _seek(_position.inMilliseconds.toDouble());
  }
  setState(() => _isPlaying = !_isPlaying);
}


// seek file
void _seek(double milliseconds) {
  _audioPlayer.seek(Duration(milliseconds: milliseconds.toInt()));
}


// return pretty play time
String _formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
}



// play control buttons & play time text & slider widgets
Row(
  children:[
    InkWell(
      onTap: () {_seek(_position.inMilliseconds.toDouble()-5000);},
      child: Container(),
    ),
    InkWell(
      onTap: () {_playPause();},
      child: Image.asset(_isPlaying?"pause_img":"play_img"),
    ),
    InkWell(
      onTap: () {_seek(_position.inMilliseconds.toDouble()-5000);},
      child: Container(),
    ),
  ]
),
Text("${_formatDuration(_position)} / ${_formatDuration(_duration)}"),
SliderTheme(
  data: SliderThemeData(
      trackHeight: 3.0,
      trackShape: const RectangularSliderTrackShape(),
    overlayShape: SliderComponentShape.noOverlay
  ),
  child: Slider(
    thumbColor: Colors.black,
    activeColor: Colors.grey, // 재생 된 부분
    inactiveColor: Colors.grey, // 재생 안된 부분
    value: _position.inMilliseconds.toDouble(),
    max: _duration.inMilliseconds.toDouble(),
    onChanged: (value) {
      _seek(value);
    },
  ),
),