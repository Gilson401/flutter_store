import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    required this.isLoading,
  }) : super(key: key);

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).cardColor;
    return Center(
      child: CircularProgressIndicator(
        color: containerColor,
      ),
    );
  }
}
