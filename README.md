# OSI — Briefing de Criação de Conteúdo

MVP offline do app OSI com formulário de briefing, persistência local e CRUD completo.

## Stack
- Flutter + Material 3
- Riverpod (estado)
- go_router (navegação)
- Hive (persistência local)

## Estrutura
```
lib/
  app/
    dependencies.dart
    providers.dart
    router.dart
    theme.dart
    state/
  data/
    hive/
    models/
    repositories/
    utils/
  domain/
    entities/
    repositories/
    usecases/
    validators/
  ui/
    screens/
```

## Funcionalidades (MVP)
- Formulário completo com Stepper, validações e campos condicionais ("Outro")
- CRUD de briefings
- Busca por nome/e-mail/Instagram ou site
- Duplicação de briefing
- Persistência offline com Hive

## Como rodar
```
flutter pub get
flutter run
```

## Testes
```
flutter test
```

## Observações
- Se o projeto não tiver as pastas de plataforma (`android/`, `ios/`, `web/`), rode:
```
flutter create .
```
- O asset do logo está em `assets/branding/osi_logo.png`.
