import 'package:flut_jestor_app/shared/utils/utils.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const Center(
        child: CircularProgressIndicator(
          color: blue,
        ),
      ),
    );
  }
}
