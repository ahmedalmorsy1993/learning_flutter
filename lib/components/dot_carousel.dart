import 'package:flutter/material.dart';

/// Full-width swipeable carousel (one item per page) with page dots underneath.
/// [items] can be any widgets (icons now, images later). Tap a dot to jump to it.
class DotCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final Color activeColor;

  const DotCarousel({
    super.key,
    required this.items,
    this.height = 280,
    this.activeColor = Colors.deepOrange,
  });

  @override
  State<DotCarousel> createState() => _DotCarouselState();
}

class _DotCarouselState extends State<DotCarousel> {
  final _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // A horizontal PageView needs a fixed height inside vertical scrollables.
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.items.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) => Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: widget.items[i],
            ),
          ),
        ),
        if (widget.items.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < widget.items.length; i++)
                GestureDetector(
                  // Opaque + padding: the whole area around the tiny dot is tappable.
                  behavior: HitTestBehavior.opaque,
                  onTap: () => _controller.animateToPage(
                    i,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 12,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: i == _current ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: i == _current
                            ? widget.activeColor
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
