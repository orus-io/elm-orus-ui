module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import NoDebug.Log
import NoDebug.TodoOrToString
import NoDeprecated
import NoExposingEverything
import NoImportingEverything
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    [ NoExposingEverything.rule
        |> Rule.ignoreErrorsForFiles []
    , NoDeprecated.rule NoDeprecated.defaults
    , NoImportingEverything.rule []
        |> Rule.ignoreErrorsForDirectories []
    , NoMissingTypeAnnotation.rule
        |> Rule.ignoreErrorsForDirectories []
    , NoMissingTypeAnnotationInLetIn.rule
    , NoMissingTypeExpose.rule
    , NoPrematureLetComputation.rule
    , NoUnused.CustomTypeConstructors.rule []
    , NoUnused.Dependencies.rule

    --, NoUnused.Exports.rule
    --    |> Rule.ignoreErrorsForFiles []
    --, NoUnused.Modules.rule
    --    |> Rule.ignoreErrorsForFiles []
    , NoUnused.Parameters.rule
        |> Rule.ignoreErrorsForFiles []
    , NoUnused.Patterns.rule

    --, NoUnused.Variables.rule
    --    |> Rule.ignoreErrorsForFiles []
    , NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
    , Simplify.rule Simplify.defaults
        |> Rule.ignoreErrorsForFiles []
    ]
