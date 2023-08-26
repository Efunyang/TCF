import 'package:echo_frontend/app_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hyper_track_handler.g.dart';

class HyperTrackHandler {
  HyperTrackHandler(this.ref);
  final Ref ref;

  String? _deviceId;
  HyperTrack? _hyperTrack;

  Future<void> init() async {
    _hyperTrack = await HyperTrack.initialize(
      hyperTrackPublicKey,
      loggingEnabled: true,
      automaticallyRequestPermissions: true,
    );
    _deviceId = await _hyperTrack?.deviceId;
    if (_hyperTrack != null && !(await _hyperTrack!.isTracking)) {
      _hyperTrack!.startTracking();
    }
  }

  String getDeviceId() => _deviceId ?? '';

  void startTracking() => _hyperTrack?.startTracking();

  String getWebViewURL() =>
      'https://embed.hypertrack.com/tracking/${_deviceId ?? ""}?publishable_key=$hyperTrackPublicKey&map_only=true&hide_controls=true&back=false&hide_trip_metadata_tag=true&hide_search=true&export=false&hide_nav=true&hide_sharing=true&layer=street&disable_dates=true&hide_selector=true';
}

@Riverpod(keepAlive: true)
HyperTrackHandler hyperTrackHandler(HyperTrackHandlerRef ref) {
  return HyperTrackHandler(ref);
}
