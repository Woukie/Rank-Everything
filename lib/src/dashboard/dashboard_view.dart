import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rank_everything/src/dashboard/thing_provider.dart';
import 'divider_button.dart';
import 'thing_view/thing_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    super.key,
    required this.landscape,
  });

  final bool landscape;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<int> _flexTop, _flexBottom;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _flexTop = IntTween(
      begin: 150000,
      end: 75000,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    _flexBottom = IntTween(
      begin: 75000,
      end: 150000,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );
    _animationController.value = 0.5;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThingProvider thingProvider = Provider.of<ThingProvider>(context);

    switch (thingProvider.selectedThing) {
      case 0:
        _animationController.animateTo(0.5);
      case 1:
        _animationController.animateTo(0.0);
      case 2:
        _animationController.animateTo(1.0);
        break;
      default:
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          children: [
            Flex(
              direction: widget.landscape ? Axis.horizontal : Axis.vertical,
              children: [
                Expanded(
                  flex: _flexTop.value,
                  child: const ThingView(top: true),
                ),
                Expanded(
                  flex: _flexBottom.value,
                  child: const ThingView(top: false),
                ),
              ],
            ),
            const DividerButton(),
          ],
        );
      },
    );
  }
}
