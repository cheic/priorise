import 'package:flutter/material.dart';

class RoleIcons {
  static const Map<String, IconData> icons = {
    'star': Icons.star_outline,
    'person': Icons.person_outline,
    'work': Icons.work_outline,
    'favorite': Icons.favorite_border,
    'brush': Icons.brush_outlined,
    'book': Icons.book_outlined,
    'fitness_center': Icons.fitness_center_outlined,
    'home': Icons.home_outlined,
    'local_cafe': Icons.local_cafe_outlined,
    'school': Icons.school_outlined,
    'explore': Icons.explore_outlined,
    'lightbulb': Icons.lightbulb_outline,
    'savings': Icons.savings_outlined,
    'directions_run': Icons.directions_run_outlined,
    'spa': Icons.spa_outlined,
    'medical': Icons.medical_services_outlined,
    'healing': Icons.healing_outlined,
  };

  static IconData getIcon(String key) {
    return icons[key] ?? Icons.star_outline;
  }
}
