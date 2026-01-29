# DECISIONS

## 29/01/2026 — Persistência local

**Escolha:** Hive

**Por quê:**
- Setup simples e rápido, sem necessidade de codegen.
- Leve para armazenamento offline de dados estruturados simples.
- Performance adequada para listas e consultas por chave.
- Mantém o MVP enxuto e fácil de evoluir.

**Trade-offs:**
- Consultas complexas e relacionais são mais limitadas.
- Caso o app evolua para filtros avançados ou relacionamentos, Drift pode ser uma alternativa futura.
