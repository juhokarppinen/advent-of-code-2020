module Main exposing (..)

import Day1
import Day2
import Html exposing (Html, div, h1, h2, li, ol, p, span, text, ul)
import Html.Attributes exposing (style)


type alias Solution =
    { heading : String
    , solutions : List String
    }


allSolutions : List Solution
allSolutions =
    [ Solution Day1.heading Day1.solutions
    , Solution Day2.heading Day2.solutions
    ]




main : Html message
main =
    div
        [ style "display" "flex"
        , style "flex-direction" "column"
        , style "align-items" "center"
        ]
        (title :: List.map viewDay allSolutions)


title : Html message
title =
    h1 [] [ text "Advent of Code 2020 – Year of Elm" ]


viewDay : Solution -> Html message
viewDay { heading, solutions } =
    div
        [ style "min-width" "25rem"
        , style "border-bottom" "1px solid #1a1a1a"
        ]
        [ h2 [] [ text heading ]
        , ol [] (List.map viewSolution solutions)
        ]


viewSolution : String -> Html msg
viewSolution solution =
    li [] [ text solution ]
