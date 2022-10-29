import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<Event> restartableDebounce<Event>(
  Duration duration, {
  required bool Function(Event) isDebounced,
}) {
  return (events, mapper) {
    final debouncedEvents = events.where(isDebounced).debounce(duration);
    final otherEvents = events.where((event) => !isDebounced(event));
    return otherEvents.merge(debouncedEvents).switchMap(mapper);
  };
}
