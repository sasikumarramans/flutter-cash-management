part of '../flutter_mentions.dart';

/// A custom implementation of [TextEditingController] to support @ mention or other
/// trigger based mentions.
class AnnotationEditingController extends TextEditingController {
  Map<String, Annotation> _mapping;
  String? _pattern;

  // Generate the Regex pattern for matching all the suggestions in one.
  AnnotationEditingController(this._mapping)
      : _pattern = _mapping.keys.isNotEmpty
            ? "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})"
            : null;

  /// Can be used to get the markup from the controller directly.
  String get markupText {
    final someVal = _mapping.isEmpty
        ? text
        : text.splitMapJoin(
            RegExp('$_pattern'),
            onMatch: (Match match) {
              final mention = _mapping[match[0]!] ??
                  _mapping[_mapping.keys.firstWhere((element) {
                    final reg = RegExp(element);

                    return reg.hasMatch(match[0]!);
                  })]!;

              // Default markup format for mentions
              if (!mention.disableMarkup) {
                return mention.markupBuilder != null
                    ? mention.markupBuilder!(
                        mention.trigger, mention.id!, mention.display!)
                    : '${mention.trigger}[__${mention.id}__](__${mention.display}__)';
              } else {
                return match[0]!;
              }
            },
            onNonMatch: (String text) {
              return text;
            },
          );

    return someVal;
  }

  /// Returns a list of maps containing the id, display, and trigger for each mention in the text.
  List<Map<String, dynamic>> get markupMentions {
    final mentions = <Map<String, dynamic>>[];

    final regex = RegExp('$_pattern');
    for (final match in regex.allMatches(text)) {
      final matchedText = match.group(0)!;

      final mention = _mapping[matchedText] ??
          _mapping[_mapping.keys.firstWhere(
            (key) => RegExp(key).hasMatch(matchedText),
            orElse: () => '',
          )];

      if (mention != null && mention.id != null && mention.display != null) {
        mentions.add({
          'id': mention.id,
          'display': mention.display,
          'trigger': mention.trigger,
        });
      }
    }

    return mentions;
  }

  Map<String, Annotation> get mapping {
    return _mapping;
  }

  set mapping(Map<String, Annotation> mapping) {
    _mapping = mapping;

    _pattern = "(${mapping.keys.map((key) => RegExp.escape(key)).join('|')})";
  }

  @override
  TextSpan buildTextSpan(
      {BuildContext? context, TextStyle? style, bool? withComposing}) {
    var children = <InlineSpan>[];

    if (_pattern == null || _pattern == '()') {
      children.add(TextSpan(text: text, style: style));
    } else {
      text.splitMapJoin(
        RegExp('$_pattern'),
        onMatch: (Match match) {
          if (_mapping.isNotEmpty) {
            final mention = _mapping[match[0]!] ??
                _mapping[_mapping.keys.firstWhere((element) {
                  final reg = RegExp(element);

                  return reg.hasMatch(match[0]!);
                })]!;

            children.add(
              TextSpan(
                text: match[0],
                style: style!.merge(mention.style),
              ),
            );
          }

          return '';
        },
        onNonMatch: (String text) {
          children.add(TextSpan(text: text, style: style));
          return '';
        },
      );
    }

    return TextSpan(style: style, children: children);
  }
}
