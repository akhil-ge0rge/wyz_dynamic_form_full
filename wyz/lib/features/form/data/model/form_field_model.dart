import 'package:wyz/features/form/domain/entities/form_fields.dart';

class FormFieldModel extends FormField {
  FormFieldModel({
    required super.id,
    required super.type,
    required super.label,
    super.min,
    super.max,
    super.placeholder,
    super.color,
    super.size,
    required super.index,
    super.options,
    super.validation,
  });

  factory FormFieldModel.fromJson(Map<String, dynamic> json) {
    double? min;
    double? max;
    FormFieldValidation? validation;

    if (json['min'] != null) {
      if (json['min'] is num) {
        min = (json['min'] as num).toDouble();
      } else if (json['min'] is String) {
        min = double.tryParse(json['min']);
      }
    }

    if (json['max'] != null) {
      if (json['max'] is num) {
        max = (json['max'] as num).toDouble();
      } else if (json['max'] is String) {
        max = double.tryParse(json['max']);
      }
    }

    if (json['validation'] != null &&
        json['validation'] is Map<String, dynamic>) {
      final validationJson = json['validation'] as Map<String, dynamic>;

      String? pattern;
      if (validationJson['pattern'] != null) {
        if (validationJson['pattern'] is String) {
          pattern = validationJson['pattern'];
        } else {
          pattern = validationJson['pattern'].toString();
        }
      }

      String? errorMessage;
      if (validationJson['errorMessage'] != null) {
        if (validationJson['errorMessage'] is String) {
          errorMessage = validationJson['errorMessage'];
        } else {
          errorMessage = validationJson['errorMessage'].toString();
        }
      }

      validation = FormFieldValidation(
        required: validationJson['required'] ?? false,
        minLength: validationJson['minLength'],
        maxLength: validationJson['maxLength'],
        pattern: pattern,
        errorMessage: errorMessage,
      );
    }

    return FormFieldModel(
      id: json['id'],
      type: json['type'],
      label: json['label'],
      placeholder: json['placeholder'],
      min: min,
      max: max,
      color: json['color'],
      size: json['size'],
      index: json['index'],
      options:
          json['options'] != null ? List<String>.from(json['options']) : null,
      validation: validation,
    );
  }

  Map<String, dynamic> toJson() {
    final validationMap = validation != null
        ? {
            'required': validation!.required,
            'minLength': validation!.minLength,
            'maxLength': validation!.maxLength,
            'pattern': validation!.pattern,
            'errorMessage': validation!.errorMessage,
          }
        : null;
    return {
      'id': id,
      'type': type,
      'label': label,
      'min': min,
      'max': max,
      'placeholder': placeholder,
      'color': color,
      'size': size,
      'index': index,
      'options': options,
      'validation': validationMap,
    };
  }
}
