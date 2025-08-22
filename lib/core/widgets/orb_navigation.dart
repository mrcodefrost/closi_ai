import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'glass_container.dart';

class OrbNavigation extends StatefulWidget {
  final Function(int) onItemSelected;
  final int currentIndex;

  const OrbNavigation({
    Key? key,
    required this.onItemSelected,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<OrbNavigation> createState() => _OrbNavigationState();
}

class _OrbNavigationState extends State<OrbNavigation>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Expanded menu items
        if (_isExpanded) ...[
          _buildMenuItem(
            icon: Icons.home_outlined,
            label: 'Home',
            index: 0,
            offset: const Offset(-80, -10),
          ),
          _buildMenuItem(
            icon: Icons.checkroom_outlined,
            label: 'Outfits',
            index: 1,
            offset: const Offset(-140, -10),
          ),
          _buildMenuItem(
            icon: Icons.camera_outlined,
            label: 'Trial',
            index: 2,
            offset: const Offset(-200, -10),
          ),
          _buildMenuItem(
            icon: Icons.person_outline,
            label: 'Profile',
            index: 3,
            offset: const Offset(-260, -10),
          ),
        ],
        // Main orb
        GestureDetector(
          onTap: _toggleExpanded,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: _isExpanded ? AppTheme.primaryColor : AppTheme.glassBlack,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              _isExpanded ? Icons.close : Icons.apps,
              color: Colors.white,
              size: 28,
            ),
          ).animate(target: _isExpanded ? 1 : 0)
              .rotate(duration: 300.ms, begin: 0, end: 0.125),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required int index,
    required Offset offset,
  }) {
    final isSelected = widget.currentIndex == index;
    return Transform.translate(
      offset: offset,
      child: GestureDetector(
        onTap: () {
          widget.onItemSelected(index);
          _toggleExpanded();
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.borderColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : AppTheme.inkColor,
            size: 24,
          ),
        ),
      ),
    ).animate()
        .fadeIn(duration: 200.ms)
        .scale(duration: 200.ms, begin: const Offset(0.5, 0.5));
  }
}
