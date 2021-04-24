import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart' as lib;

class ShimmerLoading extends StatelessWidget {
  final Widget child;

  const ShimmerLoading({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return lib.Shimmer.fromColors(
      child: child,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }
}
