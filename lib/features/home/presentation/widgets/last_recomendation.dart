import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:skincare_recomendation/core/themes/app_radius.dart';
import 'package:skincare_recomendation/core/themes/app_theme.dart';
import 'package:skincare_recomendation/core/widgets/app_container.dart';
import 'package:skincare_recomendation/core/widgets/app_divider.dart';
import 'package:go_router/go_router.dart';
import 'package:skincare_recomendation/core/widgets/app_separator.dart';
import 'package:skincare_recomendation/features/home/models/last_recomendation_model.dart';

class LastRecomendation extends StatelessWidget {
  final List<LastRecomendationModel> data;

  const LastRecomendation({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: data.map((item) => _RecomendationCard(data: item)).toList(),
    );
  }
}

class _RecomendationCard extends StatelessWidget {
  final LastRecomendationModel data;

  const _RecomendationCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          'last-recommendation',
          extra: data.productName,
        );
      },
      child: AppContainer(
        opacity: 0.8,
        showShadow: false,
        borderRadius: AppRadius.br24,
        padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              spacing: 12,
              children: [
                Expanded(
                  child: _ProductInfo(
                    title: data.productName,
                    brandName: data.brandName,
                    category: data.category,
                  ),
                ),
                _UVIndicator(uvIndex: data.uvIndex, color: data.uvColor),
              ],
            ),
          ),
          const AppDivider.dashed(),
          _Footer(date: data.createdAt),
        ],
      ),
    ));
  }
}

class _ProductInfo extends StatelessWidget {
  final String title;
  final String brandName;
  final String category;

  const _ProductInfo({
    required this.title,
    required this.brandName,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.text.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            Text(
              brandName,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.outline,
              ),
            ),
            AppSeparator.small(),
            Text(
              category,
              style: context.text.bodyMedium?.copyWith(
                color: context.colors.outline,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UVIndicator extends StatelessWidget {
  final double uvIndex;
  final Color color;

  const _UVIndicator({required this.uvIndex, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 22,
      lineWidth: 4,
      percent: (uvIndex / 12).clamp(0.0, 1.0),
      animation: true,
      animationDuration: 1000,
      curve: Curves.fastOutSlowIn,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: context.colors.onSurfaceVariant.withValues(alpha: 0.1),
      progressColor: color,
      center: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            uvIndex.toInt().toString(),
            style: context.text.labelLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            'UV',
            style: context.text.labelSmall?.copyWith(
              color: color.withValues(alpha: 0.6),
              fontSize: 7,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final DateTime date;

  const _Footer({required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        spacing: 8,
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedCalendar01,
            size: 16,
            color: context.colors.outline,
          ),
          Text(
            DateFormat('d MMM yyyy, HH:mm').format(date),
            style: context.text.bodySmall?.copyWith(
              color: context.colors.outline,
            ),
          ),
          Spacer(),
          HugeIcon(
            icon: HugeIcons.strokeRoundedArrowUpRight03,
            size: 18,
            color: context.colors.outline,
          ),
        ],
      ),
    );
  }
}
