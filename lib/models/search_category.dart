enum SearchCategory {
  popular,
  upcoming,
}

extension CategoryExtension on SearchCategory {
  static const labelMap = {
    SearchCategory.popular: 'Popular',
    SearchCategory.upcoming: 'Upcoming',
  };

  String get label => labelMap[this] ?? '';

  String get endPoint => label.toLowerCase();
}
