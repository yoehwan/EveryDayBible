part of audio_repo;

class AudioImpl extends AudioRepo {
  final AudioService audioService = AudioService();
  final StreamController<QTDuration> _durationStream =
      StreamController.broadcast();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
  AudioState state = AudioState.idle;
  bool isPlaying = false;
  @override
  Future init() async {}

  @override
  Future loadAudio(String audioURL) async {
    await audioService.loadAudio(audioURL);
    audioService.stateStream().listen((event) {
      state = AudioState.values[event.processingState.index];
      isPlaying = event.playing;
      _durationStream.add(
        QTDuration(
          isPlaying: isPlaying,
          state: state,
          position: position,
          duration: duration,
        ),
      );
    });
    audioService.durationStream().listen((event) {
      if (event != null) {
        duration = event;
        _durationStream.add(
          QTDuration(
            isPlaying: isPlaying,
            state: state,
            position: position,
            duration: duration,
          ),
        );
      }
    });
    audioService.positionStream().listen((event) {
      position = event;
      _durationStream.add(
        QTDuration(
          isPlaying: isPlaying,
          state: state,
          position: position,
          duration: duration,
        ),
      );
    });
  }

  @override
  Future pauseAudio() {
    return audioService.pause();
  }

  @override
  Future playAudio() {
    return audioService.play();
  }

  @override
  Future seekAudio(Duration duration) {
    return audioService.seek(duration);
  }

  @override
  Stream<QTDuration> durationStream() {
    return _durationStream.stream;
  }
}
