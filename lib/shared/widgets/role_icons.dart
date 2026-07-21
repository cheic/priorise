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
    'palette': Icons.palette_outlined,
    'music': Icons.music_note_outlined,
    'laptop': Icons.laptop_mac_outlined,
    'build': Icons.build_outlined,
    'flight': Icons.flight_outlined,
    'family': Icons.family_restroom_outlined,
    'pets': Icons.pets_outlined,
    'eco': Icons.eco_outlined,
    'public': Icons.public_outlined,
    'volunteer': Icons.volunteer_activism_outlined,
    'handshake': Icons.handshake_outlined,
    'money': Icons.monetization_on_outlined,
    'rocket': Icons.rocket_launch_outlined,
    'trophy': Icons.emoji_events_outlined,
    'group': Icons.groups_outlined,
    'psychology': Icons.psychology_outlined,
    'restaurant': Icons.restaurant_outlined,
  };

  static IconData getIcon(String key) {
    return icons[key] ?? Icons.star_outline;
  }
}
