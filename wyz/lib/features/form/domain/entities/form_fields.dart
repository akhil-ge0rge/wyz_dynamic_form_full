class FormFieldValidation {
  final bool required;
  final int? minLength;
  final int? maxLength;
  final String? pattern;
  final String? errorMessage;

  FormFieldValidation({
    this.required = false,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.errorMessage,
  });
}

class FormField {
  final int id;
  final String type;
  final String label;
  final double? min;
  final double? max;
  final String? placeholder;
  final String? color;
  final String? size;
  final int index;
  final List<String>? options;
  final FormFieldValidation? validation;

  FormField({
    required this.id,
    required this.type,
    required this.label,
    this.min,
    this.max,
    this.placeholder,
    this.color,
    this.size,
    required this.index,
    this.options,
    this.validation,
  });
}
