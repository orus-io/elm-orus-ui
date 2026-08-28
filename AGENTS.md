# AGENTS.md

Elm **package library** (`elm.json` type `package`), `orus-io/elm-orus-ui` — a
Material Design 3 UI toolkit that renders to
[elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/). Not
an application; there is no entry point or server.

## Toolchain

All tools are pinned via [mise](https://mise.jdx.dev) in `mise.toml` (elm
0.19.2, elm-format 0.8.8, elm-review 2.13.5, elm-json). Use `mise run` so
versions match CI expectations:

| Task | Runs | Use |
|------|------|-----|
| `mise run build` | `elm make` | compile-check the library |
| `mise run review` | `elm-review` | static analysis |
| `mise run format-validate` | `elm-format --validate src` | formatting **check only** |
| `mise run lint` | `format-validate` + `review` | the full pre-commit check |

- `mise run lint` is the canonical verification step. Run it before considering
  work done.
- `format-validate` does **not** auto-fix. To fix formatting, run `elm-format
  src` directly (no `--validate`).
- There is **no test suite**: `elm.json` has empty `test-dependencies` and
  there is no `tests/` dir. Do not look for or invent tests.

## Architecture (two-layer design)

- `src/OUI/*.elm` — renderer-agnostic component **definition/creation** APIs
  (e.g. `OUI.Button`, `OUI.Text`, `OUI.Slider`). These describe *what* a
  component is, not how it draws.
- `src/OUI/Material/*.elm` — Material (elm-ui) **renderers** that turn the
  above into `Element msg` (e.g. `OUI.Material.Button`).
- `src/OUI/Material.elm` — aggregator exposing one render fn per component:
  `Material.button theme attrs btn`, `Material.textField ...`, etc. Callers go
  through here.
- `src/OUI/Material/Theme.elm` — central `Theme`; every component's theme
  sub-record lives here and is accessed via `Theme.button theme`,
  `Theme.colorscheme theme`, `Theme.typescale theme`, …
- `src/OUI.elm` — root module, exposes only `Color`.

Customization surface for users: `OUI.Material.Color` (color schemes) and
`OUI.Material.Theme` (per-component theming).

## Adding a new component

`DEVELOP.md` documents this but is **partly stale**: the two showcase steps no
longer apply — the showcase/explorer was moved to a separate project (commit
`2219d22`). The current, correct steps:

1. Create `src/OUI/MyComponent.elm` — the definition/creation API.
2. Create `src/OUI/Material/MyComponent.elm` — the Material renderer with a
   `render` fn and its own `Theme`/`defaultTheme`.
3. Add the component's theme sub-record + accessor in
   `src/OUI/Material/Theme.elm`.
4. Add a render function in `src/OUI/Material.elm` (import the renderer, thread
   theme slices through).
5. Add `"OUI.MyComponent"` to `exposed-modules` in `elm.json`.

(Do **not** create `OUI/Showcase/*` files — the showcase lives elsewhere now.)

## elm-review constraints (enforced, non-default)

`review/src/ReviewConfig.elm` is strict. Rules an agent is most likely to trip on:

- **No `exposing (..)`** anywhere: not in module declarations
  (`NoExposingEverything`) and not in imports (`NoImportingEverything`). List
  names explicitly.
- **Type annotations required** on all top-level and `let/in` bindings
  (`NoMissingTypeAnnotation`, `NoMissingTypeAnnotationInLetIn`).
- **Exposed modules must be documented**: every exposed module needs module
  docs with `@docs` for each exposed item (`Docs.NoMissing`,
  `onlyExposed`/`exposedModules`). README/doc links are validated too.
- **No `Debug`** at all — `Debug.log`, `Debug.todo`, and `toString` are all
  banned (`NoDebug.*`).
- **Eta-reduce lambdas**: write `f`, not `\x -> f x` (`NoEtaReducibleLambdas`,
  always-remove).
- **No unused** parameters, patterns, variables, custom-type constructors, or
  dependencies.
- `VariablesBetweenCaseOf.AccessInCases` forbids a specific case-of
  variable-access pattern.
- `src/OUI/Material/Theme.elm` has 13 suppressed `Docs.ReviewLinksAndSections`
  errors (intentional, tracked in `review/suppressed/`).

## Misc

- Version bumps are manual in `elm.json` (`"version"` field); git history shows
  commits like "Bump version to 1.0.1".
- No CI workflows are present in-repo (`.github/` absent); `mise run lint` is
  the local source of truth for what CI would check.
- `docs.json` is generated Elm package docs (committed); don't hand-edit.
