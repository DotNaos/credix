import 'package:credix/Components/headercomponent.dart';
import 'package:flutter/material.dart';
// import the colors
import 'package:credix/res/custom_colors.dart';

/// This is the component that will be used in a the lists of the app
/// so it needs to be generic
///
/// The component looks like this:
///  *  |            Header component             |
///  *  |--------|-----------|--------------|-----|
///  *  | > (Click here to see the details)       |
///  *  | [details]                               |
///
/// the user can see details by clicking on the component
///
///
///  there is an optional check button that can be clicked to mark a task as completed
///  a completed task will be marked with a green check mark
///  an uncompleted task will be marked with a red cross mark
///
///  Make the component look pretty

class ListComponent extends StatefulWidget {
  const ListComponent({
    Key? key,
    required this.header,
    required this.details,
    this.checkButton = false,
  }) : super(key: key);

  final HeaderComponent header;
  final Widget details;
  final bool checkButton;

  @override
  _ListComponentState createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  bool _showDetails = false;
  bool _isCompleted = false;
  bool _pressed = false;
  bool _closing = false;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MaterialButton(
        onPressed: () {
          setState(() {
            if (_pressed) _closing = true;
            _pressed = !_pressed;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: !_pressed ? 45 : 300,
          onEnd: () {
            setState(() {
              _showDetails = !_showDetails;
              _closing = false;
            });
          },
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CustomColors.primary,
            border: Border.all(
              color: CustomColors.primary.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10),
              widget.header,
              if (_showDetails && !_closing) const SizedBox(height: 10),
              if (_showDetails && !_closing) const Divider(color: Colors.white),
              if (_showDetails && !_closing) const SizedBox(height: 10),
              if (_showDetails && !_closing) Expanded(child: widget.details),
              if (widget.checkButton)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isCompleted = !_isCompleted;
                        });
                      },
                      child: _isCompleted
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
