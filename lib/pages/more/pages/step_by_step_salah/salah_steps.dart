class SalahSteps{
  String? _title;
  String? _stepNumber;
  String? _text;

  String? get title => _title;

  String? get stepNumber => _stepNumber;

  String? get text => _text;

  SalahSteps({required title, required stepNumber, required text}){
    _title = title;
    _stepNumber = stepNumber;
    _text = text;
  }
}