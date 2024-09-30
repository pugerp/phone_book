extension Initials on String {
  String get initials {
    List<String> names = this.trim().split(' ');

    String initials = '';
    for (String name in names) {
      if (name.isNotEmpty && initials.length < 2) {
        initials += name[0].toUpperCase();
      }
    }

    return initials;
  }
}