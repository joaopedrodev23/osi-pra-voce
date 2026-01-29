class BriefingValidators {
  static bool isValidEmail(String value) {
    final trimmed = value.trim();
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(trimmed);
  }

  static String? requiredField(String? value, {String message = 'Obrigatório'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Obrigatório';
    }
    if (!isValidEmail(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  static bool isOtherRequired({required String selected, required String otherValue}) {
    return selected == 'Outro' && otherValue.trim().isEmpty;
  }

  static String? otherRequired({
    required String selected,
    required String? otherValue,
  }) {
    if (selected == 'Outro' && (otherValue == null || otherValue.trim().isEmpty)) {
      return 'Obrigatório';
    }
    return null;
  }
}
