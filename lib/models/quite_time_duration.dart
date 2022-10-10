import 'package:equatable/equatable.dart';
import 'package:everydaybible/enum/audio_state.dart';

class QuiteTimeDuration extends Equatable {
  const QuiteTimeDuration({
    required this.state,
    required this.isPlaying,
    required this.position,
    required this.duration,
  });
  final bool isPlaying;
  final AudioState state;
  final Duration position;
  final Duration duration;

  @override
  List<Object?> get props => [
        state,
        isPlaying,
        position,
        duration,
      ];
}