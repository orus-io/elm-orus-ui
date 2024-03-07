module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import Docs.NoMissing exposing (exposedModules, onlyExposed)
import Docs.ReviewAtDocs
import Docs.ReviewLinksAndSections
import Docs.UpToDateReadmeLinks
import NoConfusingPrefixOperator
import NoDebug.Log
import NoDebug.TodoOrToString
import NoDeprecated
import NoEtaReducibleLambdas
import NoExposingEverything
import NoImportingEverything
import NoMissingSubscriptionsCall
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoRecursiveUpdate
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import NoUselessSubscriptions
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    [ NoExposingEverything.rule
        |> Rule.ignoreErrorsForFiles []
    , NoDeprecated.rule NoDeprecated.defaults
    , NoConfusingPrefixOperator.rule
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
    , NoUnused.Variables.rule
        |> Rule.ignoreErrorsForFiles []
    , NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
    , Simplify.rule Simplify.defaults
        |> Rule.ignoreErrorsForFiles []
    , NoEtaReducibleLambdas.rule
        { lambdaReduceStrategy = NoEtaReducibleLambdas.AlwaysRemoveLambdaWhenPossible
        , argumentNamePredicate = always True
        }

    -- Docs-specific review config
    , Docs.NoMissing.rule
        { document = onlyExposed
        , from = exposedModules
        }
    , Docs.ReviewLinksAndSections.rule
    , Docs.ReviewAtDocs.rule
    , Docs.UpToDateReadmeLinks.rule

    -- TEA reviewer
    , NoMissingSubscriptionsCall.rule
    , NoRecursiveUpdate.rule
    , NoUselessSubscriptions.rule
    ]
