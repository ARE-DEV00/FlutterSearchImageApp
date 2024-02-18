import 'package:rxdart/rxdart.dart';

class EventBus {
  static final EventBus _singleton = EventBus._internal();
  factory EventBus() => _singleton;
  EventBus._internal();

  final _eventStream = PublishSubject<dynamic>();

  // 이벤트 발행
  void publish(dynamic data) {
    _eventStream.add(data);
  }

  // 이벤트 구독
  Stream<dynamic> get eventStream => _eventStream.stream;
}