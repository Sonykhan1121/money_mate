enum RecurringFrequency {
  daily,
  weekly,
  monthly,
  yearly,
}

extension RecurringFrequencyExtension on RecurringFrequency {
  String get name {
    switch (this) {
      case RecurringFrequency.daily:
        return 'Daily';
      case RecurringFrequency.weekly:
        return 'Weekly';
      case RecurringFrequency.monthly:
        return 'Monthly';
      case RecurringFrequency.yearly:
        return 'Yearly';
    }
  }

  String get nameBangla {
    switch (this) {
      case RecurringFrequency.daily:
        return 'প্রতিদিন';
      case RecurringFrequency.weekly:
        return 'সাপ্তাহিক';
      case RecurringFrequency.monthly:
        return 'মাসিক';
      case RecurringFrequency.yearly:
        return 'বার্ষিক';
    }
  }
}