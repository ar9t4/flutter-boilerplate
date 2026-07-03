import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/core/constants/app_dimensions.dart';
import 'package:flutter_boilerplate/core/widgets/shimmer_layout.dart';
import 'package:flutter_boilerplate/core/widgets/surface_container.dart';

class UserItemShimmer extends StatelessWidget {
  const UserItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
      radius: AppDimensions.borderRadius,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                const ShimmerLayout(width: double.infinity, height: 16),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ShimmerLayout(width: double.infinity, height: 16),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 1,
                      child: ShimmerLayout(width: double.infinity, height: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const ShimmerLayout(width: double.infinity, height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
