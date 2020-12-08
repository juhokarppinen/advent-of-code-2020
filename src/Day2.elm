module Day2 exposing (heading, solutions)

import Data.Day2 exposing (data)
import Util


parsedData : List String
parsedData =
    String.lines data


type alias Policy =
    { min : Int
    , max : Int
    , char : String
    }


type Password
    = Password String


heading : String
heading =
    "Day 2: Password Philosophy"


solutions : List String
solutions =
    [ checkWith part1
    , checkWith part2
    ]


checkWith : (Password -> Policy -> Bool) -> String
checkWith checkFn =
    List.map parse parsedData
        |> List.filter (check checkFn)
        |> List.length
        |> String.fromInt


check : (Password -> Policy -> Bool) -> Maybe ( Policy, Password ) -> Bool
check checkFn value =
    case value of
        Nothing ->
            False

        Just ( policy, password ) ->
            checkFn password policy


part1 : Password -> Policy -> Bool
part1 (Password password) { min, max, char } =
    let
        charCount =
            String.length password - (String.replace char "" password |> String.length)
    in
    charCount >= min && charCount <= max


part2 : Password -> Policy -> Bool
part2 (Password password) { min, max, char } =
    let
        match index =
            String.slice (index - 1) index password == char
    in
    xor (match min) (match max)


parse : String -> Maybe ( Policy, Password )
parse s =
    let
        ( policyString, password ) =
            Util.splitTwo ": " s

        ( minMax, char ) =
            Util.splitTwo " " policyString

        ( min, max ) =
            Util.splitTwo "-" minMax
    in
    case ( String.toInt min, String.toInt max ) of
        ( Nothing, _ ) ->
            Nothing

        ( _, Nothing ) ->
            Nothing

        ( Just minValue, Just maxValue ) ->
            Just ( Policy minValue maxValue char, Password password )
