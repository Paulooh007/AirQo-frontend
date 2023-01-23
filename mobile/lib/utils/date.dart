import 'package:app/models/models.dart';
import 'package:intl/intl.dart';

import 'exception.dart';
import 'extensions.dart';

String dateToShareString(DateTime dateTime) {
  try {
    final dateFormatter = DateFormat('EEE, d MMM yyyy hh:mm a');

    return dateFormatter.format(dateTime);
  } catch (exception, stackTrace) {
    logException(exception, stackTrace);

    return dateToString(dateTime);
  }
}

String dateToString(DateTime dateTime) {
  try {
    final now = DateTime.now();
    if (now.day == dateTime.day) {
      return 'Updated today at ${DateFormat('hh:mm a').format(dateTime)}';
    } else if (now.isAfter(dateTime)) {
      final yesterday = now.subtract(const Duration(hours: 24));
      if (dateTime.day == yesterday.day) {
        return 'Updated yesterday at'
            ' ${DateFormat('hh:mm a').format(dateTime)}';
      } else {
        final daysAgo = now.difference(dateTime).inDays;

        return daysAgo == 1
            ? 'Updated $daysAgo day ago'
            : 'Updated $daysAgo days ago';
      }
    } else {
      final tomorrow = now.add(const Duration(hours: 24));

      return tomorrow.day == dateTime.day
          ? 'Tomorrow, ${DateFormat('hh:mm a').format(dateTime)}'
          : DateFormat('d MMM, hh:mm a').format(dateTime);
    }
  } catch (exception, stackTrace) {
    logException(exception, stackTrace);

    return dateTime.toIso8601String();
  }
}

String getDateTime() {
  final now = DateTime.now();

  return '${now.getWeekday()} ${DateFormat('d').format(now)},'
          ' ${DateFormat('MMMM').format(now)}'
      .toUpperCase();
}

String chartTitleDateTimeTitle({
  required DateTime dateTime,
  required Frequency frequency,
  bool showingForecast = false,
}) {
  if (showingForecast) {
    if (dateTime.isToday()) {
      return 'Today’s forecast';
    } else if (dateTime.isTomorrow()) {
      return 'Tomorrow’s forecast';
    } else {
      return dateTime.getLongDate();
    }
  }
  try {
    String prefix = '';
    String suffix = '';
    switch (frequency) {
      case Frequency.daily:
        suffix = '${dateTime.getDateOfFirstDayOfWeek().getShortDate()}'
            ' - '
            '${dateTime.getDateOfLastDayOfWeek().getShortDate()}';

        if (dateTime.isInWeek('last')) {
          prefix = 'Last Week';
        } else if (dateTime.isInWeek('this')) {
          prefix = 'This Week';
        } else if (dateTime.isInWeek('next')) {
          prefix = 'Next Week';
        } else {
          prefix = '';
        }
        break;
      case Frequency.hourly:
        suffix = dateTime.getLongDate();

        if (dateTime.isToday()) {
          prefix = 'Today';
        } else if (dateTime.isYesterday()) {
          prefix = 'Yesterday';
        } else if (dateTime.isTomorrow()) {
          prefix = 'Tomorrow';
        } else {
          prefix = dateTime.getWeekday().toTitleCase();
        }
        break;
    }

    return prefix == '' ? suffix : '$prefix, $suffix';
  } catch (exception, stackTrace) {
    logException(exception, stackTrace);

    return dateTime.toString();
  }
}
