import 'package:flutter/material.dart';
import 'package:mood_app/widgets/emote.dart';

Emote getAverageEmote(List<Emote> emotes) {
  var popular = <Emote, int>{};

  for (var element in emotes) {
    popular.update(
      element,
      (count) => ++count,
      ifAbsent: () => 1,
    );
  }

  final popularSorted = popular.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  return popularSorted.last.key;
}
