# Cupertino Store (cstoreb)

App e-commerce con diseño iOS nativo (Cupertino), catálogo de 38 productos boutique, búsqueda y carrito de compras.

## Stack

| Capa | Tecnología |
|------|-----------|
| Framework | Flutter 3.x / Dart 3.x |
| UI | Cupertino (iOS-style) |
| Estado | Provider (ChangeNotifier) |
| Formateo | intl (moneda) |
| CI/CD | GitHub Actions |

## Funcionalidades

- Catálogo de 38 productos en 3 categorías (accessories, clothing, home)
- Filtrado por categoría con chips
- Búsqueda en tiempo real por nombre de producto
- Carrito de compras con control de cantidades
- Resumen de orden: subtotal, envío ($7/artículo), impuesto (6%), total
- Formulario de checkout con campos de nombre, correo, dirección y selector de fecha/hora
- Diseño 100% Cupertino: CupertinoApp, CupertinoTabScaffold, CupertinoListTile, etc.
- Pruebas unitarias integrales (13 tests: modelos, carrito, costos, búsqueda, filtros)

## Estructura

```
lib/
├── main.dart           # Entry point + CupertinoApp
├── models.dart         # Product model + Category enum
├── repository.dart     # Catálogo estático (38 productos)
├── statemodel.dart     # ChangeNotifier (carrito, filtros, búsqueda)
├── productlist.dart    # Lista de productos con categorías
├── search.dart         # Búsqueda en tiempo real
├── cart.dart           # Carrito + checkout form
└── styles.dart         # Constantes de color y texto
```

## Inicio rápido

```bash
flutter pub get
flutter run
```

## Pruebas

```bash
flutter test
```

## Notas

- Inspirado en el demo Shrine de Flutter, reimplementado en Cupertino
- Todos los datos son hardcoded (sin backend)
- Paleta rosa (#FCE9F1), teal (#73BBC9), dorado (#DAA520)
- Orientación bloqueada a retrato
