part of '../profile_screen.dart';

class _UserSummary extends StatelessWidget {
  const _UserSummary({required this.user, required this.onEditPhoto});

  final MockUser user;
  final VoidCallback onEditPhoto;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkAmethyst.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.sunflowerGold,
                child: user.avatarUrl != null
                    ? CircleAvatar(
                        radius: 31,
                        backgroundImage: FileImage(File(user.avatarUrl!)),
                      )
                    : CircleAvatar(
                        radius: 31,
                        backgroundColor: AppColors.hotRose.withValues(
                          alpha: 0.12,
                        ),
                        child: Text(
                          user.initials,
                          style: AppTypography.heading.copyWith(
                            color: AppColors.hotRose,
                            fontSize: 23,
                          ),
                        ),
                      ),
              ),
              Positioned(
                right: -2,
                bottom: -1,
                child: Material(
                  color: AppColors.hotRose,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: onEditPhoto,
                    customBorder: const CircleBorder(),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.edit, color: Colors.white, size: 13),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          Container(width: 1, height: 72, color: AppColors.lavenderVeil),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user.fullName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.subtitle.copyWith(
                    color: AppColors.darkAmethyst,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.caption.copyWith(
                    color: AppColors.nightBordeaux,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

