enum SearchCategory {
  popular,
  upcoming,
  none,
}

extension CategoryExtension on SearchCategory {
  static const labelMap = {
    SearchCategory.popular: 'Popular',
    SearchCategory.upcoming: 'Upcoming',
  };

  String get label => labelMap[this] ?? '';
}
