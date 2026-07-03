import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/base/base_stateless.dart';
import 'package:flutter_boilerplate/core/widgets/circular_progress_bar.dart';

class LoadMoreProgress extends BaseStatelessWidget {
  const LoadMoreProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Center(
        child: CircularProgressBar(),
      ),
    );
  }
}
