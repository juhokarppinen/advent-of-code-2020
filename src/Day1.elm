module Day1 exposing (heading, solutions)

import Data.Day1 exposing (data)
import Util


parsedData : List Int
parsedData =
    String.lines data |> Util.parseIntList []


heading : String
heading =
    "Day 1: Report Repair"


solutions : List String
solutions =
    List.map String.fromInt [ part1, part2 ]


part1 : Int
part1 =
    findTwoNumbers (List.head parsedData) (List.drop 1 parsedData) (List.drop 1 parsedData) 2020 |> List.product


part2 : Int
part2 =
    findThreeNumbers (List.head parsedData) (List.drop 1 parsedData) (List.drop 1 parsedData) |> List.product


findTwoNumbers : Maybe Int -> List Int -> List Int -> Int -> List Int
findTwoNumbers candidate remainingCandidates allCandidates target =
    case candidate of
        Nothing ->
            case allCandidates of
                [] ->
                    [ 0 ]

                x :: xs ->
                    findTwoNumbers (Just x) xs xs target

        Just a ->
            case remainingCandidates of
                [] ->
                    findTwoNumbers Nothing remainingCandidates allCandidates target

                b :: bs ->
                    let
                        result =
                            [ a, b ]
                    in
                    if List.sum result == target then
                        result

                    else
                        findTwoNumbers candidate bs allCandidates target


findThreeNumbers : Maybe Int -> List Int -> List Int -> List Int
findThreeNumbers candidate remainingCandidates allCandidates =
    if List.length remainingCandidates == 0 && List.length allCandidates <= 3 then
        [ 0 ]

    else
        case candidate of
            Nothing ->
                [ 0 ]

            Just a ->
                case remainingCandidates of
                    [] ->
                        [ 0 ]

                    b :: bs ->
                        let
                            result =
                                a :: findTwoNumbers (Just b) bs bs (2020 - a)

                            newCandidate =
                                List.head allCandidates

                            newCandidates =
                                List.drop 1 allCandidates
                        in
                        if List.sum result == 2020 then
                            result

                        else
                            findThreeNumbers newCandidate newCandidates newCandidates
