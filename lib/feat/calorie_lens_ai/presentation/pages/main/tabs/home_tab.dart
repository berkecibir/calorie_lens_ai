import 'package:calorie_lens_ai_app/core/sizes/app_sizes.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.s16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Karşılama Başlığı ---
            _buildGreetingSection(theme),
            const SizedBox(height: AppSizes.s24),

            // --- Günlük Kalori Kartı ---
            _buildDailyCalorieCard(theme),
            const SizedBox(height: AppSizes.s16),

            // --- Makro Özet ---
            _buildMacroSummaryRow(theme),
            const SizedBox(height: AppSizes.s24),

            // --- Hızlı Erişim Butonları ---
            _buildQuickActions(theme),
          ],
        ),
      ),
    );
  }

  // ─── Karşılama ───
  Widget _buildGreetingSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Merhaba! 👋',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.s4),
        Text(
          'Bugünkü beslenme özetine göz at',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  // ─── Günlük Kalori Kartı ───
  Widget _buildDailyCalorieCard(ThemeData theme) {
    const consumed = 1450;
    const target = 2200;
    const remaining = target - consumed;
    const progress = consumed / target;

    return Container(
      padding: const EdgeInsets.all(AppSizes.s20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSizes.s16),
      ),
      child: Row(
        children: [
          // Progress göstergesi
          SizedBox(
            width: AppSizes.s80,
            height: AppSizes.s80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: AppSizes.s8,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Center(
                  child: Text(
                    '${(progress * 100).toInt()}%',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.s20),

          // Kalori Bilgileri
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Günlük Kalori',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSizes.s8),
                _calorieInfoRow('Tüketilen', '$consumed kcal'),
                const SizedBox(height: AppSizes.s4),
                _calorieInfoRow('Hedef', '$target kcal'),
                const SizedBox(height: AppSizes.s4),
                _calorieInfoRow('Kalan', '$remaining kcal'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calorieInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: AppSizes.s13,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: AppSizes.s13,
          ),
        ),
      ],
    );
  }

  // ─── Makro Özet ───
  Widget _buildMacroSummaryRow(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: _macroCard(
            theme,
            label: 'Protein',
            current: 85,
            target: 150,
            color: const Color(0xFF42A5F5),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: _macroCard(
            theme,
            label: 'Karbonhidrat',
            current: 180,
            target: 250,
            color: const Color(0xFFFFA726),
          ),
        ),
        const SizedBox(width: AppSizes.s8),
        Expanded(
          child: _macroCard(
            theme,
            label: 'Yağ',
            current: 40,
            target: 70,
            color: const Color(0xFFEF5350),
          ),
        ),
      ],
    );
  }

  Widget _macroCard(
    ThemeData theme, {
    required String label,
    required int current,
    required int target,
    required Color color,
  }) {
    final progress = current / target;
    return Container(
      padding: const EdgeInsets.all(AppSizes.s12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.s12),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSizes.s8),
          SizedBox(
            width: AppSizes.s40,
            height: AppSizes.s40,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: AppSizes.s4,
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: AppSizes.s8),
          Text(
            '${current}g',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '/ ${target}g',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  // ─── Hızlı Erişim ───
  Widget _buildQuickActions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hızlı Erişim',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.s12),
        Row(
          children: [
            Expanded(
              child: _quickActionButton(
                theme,
                icon: Icons.camera_alt_rounded,
                label: 'Yemek Tara',
                color: theme.colorScheme.primary,
                onTap: () {
                  // TODO: Navigate to food scan
                },
              ),
            ),
            const SizedBox(width: AppSizes.s12),
            Expanded(
              child: _quickActionButton(
                theme,
                icon: Icons.edit_rounded,
                label: 'Manuel Ekle',
                color: const Color(0xFFFFA726),
                onTap: () {
                  // TODO: Navigate to manual entry
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickActionButton(
    ThemeData theme, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSizes.s12),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.s20,
          horizontal: AppSizes.s16,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSizes.s12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: AppSizes.s32),
            const SizedBox(height: AppSizes.s8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
