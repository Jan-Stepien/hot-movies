import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<Event> restartableDebounce<Event>(
  Duration duration,
) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

EventTransformer<Event> restartable<Event>() {
  return (events, mapper) {
    return events.switchMap(mapper);
  };
}
