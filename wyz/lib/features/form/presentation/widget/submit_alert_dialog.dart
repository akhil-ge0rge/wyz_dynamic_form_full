import 'package:flutter/material.dart';
import 'package:wyz/features/form/presentation/provider/form_provider.dart';

class SubmitAlertDialog extends StatefulWidget {
  final FormProvider provider;
  const SubmitAlertDialog({super.key, required this.provider});

  @override
  State<SubmitAlertDialog> createState() => _SubmitAlertDialogState();
}

class _SubmitAlertDialogState extends State<SubmitAlertDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _initScaleAnimation();
    super.initState();
  }

  //Animation Scales the dialog size from 0 to 1
  // in duration of 1 second
  void _initScaleAnimation() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    // dispose the [AnimationController] to release resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Transform.scale(
        alignment: Alignment.bottomCenter,
        scale: _animation.value,
        child: child,
      ),
      child: AlertDialog(
        title: const Text("Form Submission Data"),
        content: SizedBox(
          height: 300,
          width: double.maxFinite,
          child: ListView.separated(
            itemCount: widget.provider.formValues.length,
            itemBuilder: (context, index) {
              //fetchingName using Id from api response
              final nameById = widget.provider.appResponse?.data?.fields.where(
                (element) =>
                    element.id ==
                    widget.provider.formValues.keys.elementAt(index),
              );
              return Text(
                "${widget.provider.formValues.keys.elementAt(index)} - ${nameById?.first.label} - ${widget.provider.formValues.values.elementAt(index)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              //reverse the animation
              await _controller.reverse();
              //check if the widget is still in the widget tree and remove the [AlertDialog]
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text("Close"),
          )
        ],
      ),
    );
  }
}
