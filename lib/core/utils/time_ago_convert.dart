String timeAgo({required DateTime dateTime}) {
  return DateTime.now().difference(dateTime).inMinutes <= 59
      ? "${DateTime.now().difference(dateTime).inMinutes} min ago"
      : DateTime.now().difference(dateTime).inHours <= 23
          ? "${DateTime.now().difference(dateTime).inHours} hour ago"
          : DateTime.now().difference(dateTime).inDays <= 1
              ? "${DateTime.now().difference(dateTime).inDays} day ago"
              : "${DateTime.now().difference(dateTime).inDays} days ago";
}
