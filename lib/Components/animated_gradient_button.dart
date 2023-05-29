import 'package:flutter/material.dart';

class AnimatedGradientButton extends StatefulWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Gradient gradient;

  const AnimatedGradientButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    required this.gradient,
  }) : super(key: key);

  @override
  _AnimatedGradientButtonState createState() => _AnimatedGradientButtonState();
}

class _AnimatedGradientButtonState extends State<AnimatedGradientButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.0, end: 0.75).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (BuildContext context, Widget? child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            // lerp through the list of colors defined in the gradient
            color: Color.lerp(
              Color.lerp(
                widget.gradient.colors[0],
                widget.gradient.colors[1],
                _animation.value * _animation.value,
              ),
              widget.gradient.colors[2],
              _animation.value * _animation.value,
            ),

            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              widget.buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
