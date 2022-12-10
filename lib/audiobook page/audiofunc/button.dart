import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'common.dart';

// Displays the play/pause button and volume/speed sliders.
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Spacer(),
        // Opens volume slider dialog
        IconButton(
          icon: Icon(Icons.volume_up_outlined),
          color: Colors.blue,
          iconSize: 30,
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust volume",
              divisions: 10,
              min: 0.1,
              max: 1,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: 
              player.setVolume,
            );
          },
        ),
        // Spacer(),

        /// This StreamBuilder rebuilds whenever the player state changes, which
        /// includes the playing/paused state and also the
        /// loading/buffering/ready state. Depending on the state we show the
        /// appropriate button or loading indicator.
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading || 
                processingState == ProcessingState.buffering) {
              return 
              // CircularProgressIndicator(strokeWidth: 2);
              
              
              Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(strokeWidth: 4,),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_circle_outline_rounded),
                iconSize: 64.0,
                onPressed: player.play,
                color: Colors.blue,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause_circle_outline),
                iconSize: 64.0,
                onPressed: player.pause,
                color: Colors.blue,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay_sharp),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
                color: Colors.blue,
              );
            }
          },
        ),
        // Spacer(),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            color: Colors.blue,
            iconSize: 30,
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
            style: GoogleFonts.ubuntu(textStyle:TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust speed",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
        // Spacer(),
      ],
    );
  }
}
