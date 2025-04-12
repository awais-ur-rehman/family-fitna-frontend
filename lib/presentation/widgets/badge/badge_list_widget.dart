import 'package:flutter/material.dart';
import '../../../domain/entities/badge_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BadgeListWidget extends StatelessWidget {
  final List<BadgeEntity> badges;
  final Function(BadgeEntity) onBadgeTap;

  const BadgeListWidget({
    Key? key,
    required this.badges,
    required this.onBadgeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: badges.length,
        itemBuilder: (context, index) {
          final badge = badges[index];
          return _BadgeItem(
            badge: badge,
            onTap: () => onBadgeTap(badge),
          );
        },
      ),
    );
  }
}

class _BadgeItem extends StatelessWidget {
  final BadgeEntity badge;
  final VoidCallback onTap;

  const _BadgeItem({
    Key? key,
    required this.badge,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: badge.imageUrl != null && badge.imageUrl!.isNotEmpty
                    ? CachedNetworkImage(
                  imageUrl: badge.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.emoji_events,
                      color: Colors.white,
                    ),
                  ),
                )
                    : Container(
                  color: Colors.amber[700],
                  child: const Icon(
                    Icons.emoji_events,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              badge.name,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}