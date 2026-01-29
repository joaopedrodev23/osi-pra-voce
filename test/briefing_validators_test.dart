import 'package:flutter_test/flutter_test.dart';

import 'package:osi_pra_voce/domain/validators/briefing_validators.dart';

void main() {
  test('validação de e-mail', () {
    expect(BriefingValidators.isValidEmail('camilla@exemplo.com'), isTrue);
    expect(BriefingValidators.isValidEmail('camilla@'), isFalse);
    expect(BriefingValidators.isValidEmail('camilla.com'), isFalse);
  });

  test('regra de "Outro" obrigatório', () {
    expect(
      BriefingValidators.isOtherRequired(selected: 'Outro', otherValue: ''),
      isTrue,
    );
    expect(
      BriefingValidators.isOtherRequired(
        selected: 'Outro',
        otherValue: 'Conteúdo específico',
      ),
      isFalse,
    );
    expect(
      BriefingValidators.isOtherRequired(
        selected: 'Engajamento',
        otherValue: '',
      ),
      isFalse,
    );
  });
}
