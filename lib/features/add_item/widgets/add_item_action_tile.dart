import 'package:ai_closet_flutter/core/theme/color_constants.dart';
import 'package:flutter/material.dart';

class AddItemActionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const AddItemActionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shadowColor: ShadowColor.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: IconColor.lightBrown,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: IconColor.brown),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: ButtonColor.offWhite, // ButtonColor.offWhite
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        splashColor: ButtonColor.darkBrown,
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
        trailing: const Icon(Icons.arrow_forward_ios, color: IconColor.brown),
        onTap: onTap,
      ),
    );
  }
}
