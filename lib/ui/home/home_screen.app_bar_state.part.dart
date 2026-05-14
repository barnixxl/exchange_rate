part of 'home_screen.dart';

Widget _buildAppBarWidget({
  required DateTime? lastUpdateDate,
  required bool isLoading,
  required void Function() onRetryPressed,
}) {
  return AppBar(
    title: Text(
      strings.home_title,
    ),
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.onPrimary,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(
        40,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          8,
        ),
        color: AppColors.primaryDark,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.update,
              size: 16,
                color: AppColors.onPrimarySubtle,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              strings.updated_at(
                lastUpdateDate?.toDayMonthYearTextDateFormat() ??
                    strings.common_absent_date,
              ),
              style: const TextStyle(
              color: AppColors.onPrimarySubtle,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.onPrimary,
                  strokeWidth: 2,
                ),
              )
            : const Icon(
                Icons.refresh,
              ),
        onPressed: isLoading ? null : onRetryPressed,
      ),
    ],
  );
}
