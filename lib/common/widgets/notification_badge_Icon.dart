
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/notification_utility.dart';

class NotificationBadgeIcon extends StatefulWidget {
  final int count;
  final VoidCallback? onTap;
  const NotificationBadgeIcon({super.key, required this.count , this.onTap,});

  @override
  State<NotificationBadgeIcon> createState() => _NotificationBadgeIconState();
}

class _NotificationBadgeIconState extends State<NotificationBadgeIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late int _displayCount;
  StreamSubscription<int>? _badgeSub;

  @override
  void initState() {
    super.initState();
    _displayCount = widget.count;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _scale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    // start according to initial display count
    if (_displayCount > 0) {
      _controller.value = 1.0;
    } else {
      _controller.value = 0.0;
    }

    // load persisted badge and listen for updates
    NotificationUtility.getBadgeCount().then((value) {
      if (!mounted) return;
      _updateCount(value, animateIfNeeded: true);
    });

    _badgeSub = NotificationUtility.badgeStream.listen((count) {
      if (!mounted) return;
      _updateCount(count, animateIfNeeded: true);
    });

  }

  void _updateCount(int newCount, {bool animateIfNeeded = false}) {
    final old = _displayCount;
    if (newCount == old) return;
    setState(() {
      _displayCount = newCount;
    });

    if (animateIfNeeded) {
      if (old == 0 && newCount > 0) {
        _controller.forward(from: 0.0);
      } else if (old > 0 && newCount == 0) {
        _controller.reverse();
      } else if (old > 0 && newCount > 0) {
        // optional pulse on count change
        _controller.forward(from: 0.0);
      }
    }
  }


  @override
  void didUpdateWidget(NotificationBadgeIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateCount(widget.count, animateIfNeeded: true);
    // if (widget.count != oldWidget.count) {
    //   if (widget.count > 0) {
    //     // restart animation from the beginning
    //     _controller.forward(from: 0.0);
    //   } else {
    //     // optionally animate out when count goes to zero
    //     _controller.reverse();
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const FaIcon(FontAwesomeIcons.bell, size: 25),
          if (widget.count > 0)
            Positioned(
              right: -5,
              top: -7,
              child: ScaleTransition(
                scale: _scale,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    _displayCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _badgeSub?.cancel();
    _controller.dispose();
    super.dispose();
  }
}