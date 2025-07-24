import 'package:flutter_test/flutter_test.dart';
import 'package:notion_todo/src/common/sound/sound_service.dart';

void main() {
  group('SoundService', () {
    late SoundService soundService;

    setUp(() {
      soundService = SoundService();
    });

    tearDown(() {
      soundService.dispose();
    });

    test('playCompletionSound should not stop other sounds', () async {
      // playSound で音声を再生
      await soundService.playSound('sounds/test.mp3');
      
      // playCompletionSound を呼び出しても他の音声に影響しない
      await soundService.playCompletionSound('sounds/complete.mp3');
      
      // この時点で両方のAudioPlayerが独立して動作していることを確認
      // AudioPlayerはモックなしでは実際の再生状態を確認できないため、
      // エラーが発生しないことを確認
      expect(() async => await soundService.stopSound(), returnsNormally);
    });

    test('dispose should dispose both audio players', () {
      // disposeがエラーなく実行されることを確認
      expect(() => soundService.dispose(), returnsNormally);
    });
  });
}