extension DateExtensions on DateTime {
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);
    if (hours > 0) {
      return minutes > 0 ? '${hours}h ${minutes}m ago' : '${hours}h ago';
    }
    return minutes > 0 ? '${minutes}m ago' : 'Just now';
  }
}
