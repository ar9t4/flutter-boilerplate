import 'package:flutter/widgets.dart';

class ShimmerListView extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Widget item;
  final int itemCount;

  const ShimmerListView({
    super.key,
    this.margin,
    this.padding,
    required this.item,
    this.itemCount = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      padding: margin,
      itemBuilder: (context, index) => Padding(
        padding: padding ?? EdgeInsets.zero,
        child: item,
      ),
    );
  }
}
