import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// [minScrollDistance] if you do not want Unfocuser
/// to remove current focus on scroll, set this value
/// as you prefer. By default it's set to 10 pixels
/// this means that if you touch the screen and drag
/// more that 10 pixels it will be considered as
/// scrolling and unfocuser will not trigger
/// In case you want it to always unfocus current text field
/// just set this value to 0.0
class Unfocuser extends StatefulWidget {
  final Widget? child;
  final double minScrollDistance;

  const Unfocuser({
    Key? key,
    this.child,
    this.minScrollDistance = 10.0,
  }) : super(key: key);

  @override
  _UnfocuserState createState() => _UnfocuserState();
}

class _UnfocuserState extends State<Unfocuser> {
  RenderBox? _lastRenderBox;
  Offset? _touchStartPosition;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        _touchStartPosition = e.position;
      },
      onPointerUp: (e) {
        var touchStopPosition = e.position;
        if (widget.minScrollDistance > 0.0 && _touchStartPosition != null) {
          var difference = _touchStartPosition! - touchStopPosition;
          _touchStartPosition = null;
          if (difference.distance > widget.minScrollDistance) {
            return;
          }
        }

        var rb = context.findRenderObject() as RenderBox;
        var result = BoxHitTestResult();
        rb.hitTest(result, position: touchStopPosition);

        if (result.path.any(
            (entry) => entry.target.runtimeType == IgnoreUnfocuserRenderBox)) {
          return;
        }
        var isEditable = result.path.any((entry) =>
            entry.target.runtimeType == RenderEditable ||
            entry.target.runtimeType == RenderParagraph ||
            entry.target.runtimeType == ForceUnfocuserRenderBox);

        var currentFocus = FocusScope.of(context);
        if (!isEditable) {
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            _lastRenderBox = null;
          }
        } else {
          for (var entry in result.path) {
            var isEditable = entry.target.runtimeType == RenderEditable ||
                entry.target.runtimeType == RenderParagraph ||
                entry.target.runtimeType == ForceUnfocuserRenderBox;

            if (isEditable) {
              var renderBox = (entry.target as RenderBox);
              if (_lastRenderBox != renderBox) {
                _lastRenderBox = renderBox;
                setState(() {});
              }
            }
          }
        }
      },
      child: widget.child,
    );
  }
}

class IgnoreUnfocuser extends SingleChildRenderObjectWidget {
  // ignore: use_key_in_widget_constructors
  const IgnoreUnfocuser({required this.child}) : super(child: child);

  // ignore: overridden_fields, annotate_overrides
  final Widget child;

  @override
  IgnoreUnfocuserRenderBox createRenderObject(BuildContext context) {
    return IgnoreUnfocuserRenderBox();
  }
}

class ForceUnfocuser extends SingleChildRenderObjectWidget {
  // ignore: annotate_overrides, overridden_fields
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const ForceUnfocuser({required this.child}) : super(child: child);

  @override
  ForceUnfocuserRenderBox createRenderObject(BuildContext context) {
    return ForceUnfocuserRenderBox();
  }
}

class IgnoreUnfocuserRenderBox extends RenderPointerListener {}

class ForceUnfocuserRenderBox extends RenderPointerListener {}
