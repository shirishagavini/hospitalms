import "package:flutter/material.dart";
import "package:uuid/uuid.dart";
import "package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart";

class VideoConference extends StatelessWidget
{
  const VideoConference({super.key, required this.conferenceId, this.name});
  final String conferenceId;
  final String? name;

  @override
  Widget build(BuildContext context)
  {
    final userId = const Uuid().v1();
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 321191155,
        appSign:
        "c7314fbd1fa5aaefc6fb71216fc62beb3a7df7c51491b4c4e2a99cfc70a580d4",
        conferenceID: conferenceId,
        userID: userId,
        userName: name.toString(),
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}
