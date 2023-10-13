import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class Skeleton extends StatefulWidget {
  bool enabled;
  Widget child;
  double size;

  Skeleton(
      {super.key, this.enabled = true, required this.child, this.size = 24.0});

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> {
  @override
  Widget build(BuildContext context) {
    return widget.enabled
        ? Shimmer.fromColors(
            enabled: true,
            baseColor: Colors.transparent,
            highlightColor: Theme.of(context).highlightColor,
            child: Container(
              width: double.infinity,
              height: widget.size,
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 8.0),
            ),
          )
        : widget.child;
  }
}
