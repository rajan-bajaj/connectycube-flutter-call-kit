import 'dart:convert';

import 'package:flutter/foundation.dart';

/// {@template call_event}
/// Information about the call events (e.g. CallAccepted / CallRejected)
/// {@endtemplate}
@immutable
class CallEvent {
  /// {@macro call_event}
  const CallEvent({
    required this.sessionId,
    required this.callType,
    required this.callerId,
    required this.callerName,
    required this.opponentsIds,
    this.callPhoto,
    this.userInfo,
    this.textTitle,
    this.textSubtitle,
    this.textColor,
    this.mainColor,
  });

  final String sessionId;
  final int callType;
  final int callerId;
  final String callerName;
  final Set<int> opponentsIds;
  final String? callPhoto;

  /// Extra customization fields
  final String? textTitle;
  final String? textSubtitle;
  final String? textColor;
  final String? mainColor;

  /// Used for exchanging additional data between the Call notification and your app,
  /// you will get this data in event callbacks (e.g. onCallAcceptedWhenTerminated,
  /// onCallAccepted, onCallRejectedWhenTerminated, or onCallRejected)
  /// after setting it in method showCallNotification
  final Map<String, String>? userInfo;

  CallEvent copyWith({
    String? sessionId,
    int? callType,
    int? callerId,
    String? callerName,
    Set<int>? opponentsIds,
    String? callPhoto,
    Map<String, String>? userInfo,
    String? textTitle,
    String? textSubtitle,
    String? textColor,
    String? mainColor,
  }) {
    return CallEvent(
      sessionId: sessionId ?? this.sessionId,
      callType: callType ?? this.callType,
      callerId: callerId ?? this.callerId,
      callerName: callerName ?? this.callerName,
      opponentsIds: opponentsIds ?? this.opponentsIds,
      callPhoto: callPhoto ?? this.callPhoto,
      userInfo: userInfo ?? this.userInfo,
      textTitle: textTitle ?? this.textTitle,
      textSubtitle: textSubtitle ?? this.textSubtitle,
      textColor: textColor ?? this.textColor,
      mainColor: mainColor ?? this.mainColor,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'session_id': sessionId,
      'call_type': callType,
      'caller_id': callerId,
      'caller_name': callerName,
      'call_opponents': opponentsIds.join(','),
      'photo_url': callPhoto,
      'user_info': jsonEncode(userInfo ?? <String, String>{}),
      'text_title': textTitle,
      'text_subtitle': textSubtitle,
      'text_color': textColor,
      'main_color': mainColor,
    };
  }

  factory CallEvent.fromMap(Map<String, dynamic> map) {
    print('[CallEvent.fromMap] map: $map');
    return CallEvent(
      sessionId: map['session_id'] as String,
      callType: map['call_type'] as int,
      callerId: map['caller_id'] as int,
      callerName: map['caller_name'] as String,
      opponentsIds:
          (map['call_opponents'] as String).split(',').map(int.parse).toSet(),
      callPhoto: map['photo_url'],
      userInfo: map['user_info'] != null
          ? Map<String, String>.from(jsonDecode(map['user_info']))
          : null,
      textTitle: map['text_title'],
      textSubtitle: map['text_subtitle'],
      textColor: map['text_color'],
      mainColor: map['main_color'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CallEvent.fromJson(String source) =>
      CallEvent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CallEvent('
        'sessionId: $sessionId, '
        'callType: $callType, '
        'callerId: $callerId, '
        'callerName: $callerName, '
        'opponentsIds: $opponentsIds, '
        'callPhoto: $callPhoto, '
        'userInfo: $userInfo, '
        'textTitle: $textTitle, '
        'textSubtitle: $textSubtitle, '
        'textColor: $textColor, '
        'mainColor: $mainColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CallEvent &&
        other.sessionId == sessionId &&
        other.callType == callType &&
        other.callerId == callerId &&
        other.callerName == callerName &&
        setEquals(other.opponentsIds, opponentsIds) &&
        other.callPhoto == callPhoto &&
        mapEquals(other.userInfo, userInfo) &&
        other.textTitle == textTitle &&
        other.textSubtitle == textSubtitle &&
        other.textColor == textColor &&
        other.mainColor == mainColor;
  }

  @override
  int get hashCode {
    return sessionId.hashCode ^
        callType.hashCode ^
        callerId.hashCode ^
        callerName.hashCode ^
        opponentsIds.hashCode ^
        userInfo.hashCode ^
        textTitle.hashCode ^
        textSubtitle.hashCode ^
        textColor.hashCode ^
        mainColor.hashCode;
  }
}
