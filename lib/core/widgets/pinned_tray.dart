import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'glass_container.dart';

class PinnedTray extends StatelessWidget {
  final List<String> selectedItems;
  final VoidCallback? onViewOutfit;
  final Function(String)? onRemoveItem;

  const PinnedTray({
    Key? key,
    required this.selectedItems,
    this.onViewOutfit,
    this.onRemoveItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedItems.isEmpty) return const SizedBox.shrink();

    return Positioned(
      bottom: 90,
      left: 20,
      right: 20,
      child: GlassContainer(
        borderRadius: AppTheme.radiusM,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingM,
          vertical: AppTheme.paddingS,
        ),
        child: Row(
          children: [
            ...selectedItems.take(4).map((item) => _buildItemThumbnail(item)),
            if (selectedItems.length > 4)
              Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  color: AppTheme.inkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '+${selectedItems.length - 4}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.inkColor,
                    ),
                  ),
                ),
              ),
            const Spacer(),
            ElevatedButton(
              onPressed: onViewOutfit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.glassBlack,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                minimumSize: const Size(100, 36),
              ),
              child: const Text(
                'View Outfit',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ).animate()
          .slideY(begin: 2, end: 0, duration: 300.ms)
          .fadeIn(duration: 300.ms),
    );
  }

  Widget _buildItemThumbnail(String item) {
    return Container(
      width: 36,
      height: 36,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppTheme.borderColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.borderColor,
          width: 1,
        ),
      ),
      child: const Icon(
        Icons.checkroom,
        size: 18,
        color: AppTheme.inkColor,
      ),
    );
  }
}
