module Day3 exposing (heading, solutions)

import Data.Day3 exposing (data)


parsedData : List String
parsedData =
    String.lines data


type alias Vector =
    { x : Int
    , y : Int
    }


heading : String
heading =
    "Day 3: Toboggan Trajectory"


solutions : List String
solutions =
    List.map String.fromInt [ part1, part2 ]


part1 : Int
part1 =
    getCountForSlope (Vector 3 1)


part2 : Int
part2 =
    let
        slopes =
            [ Vector 1 1
            , Vector 3 1
            , Vector 5 1
            , Vector 7 1
            , Vector 1 2
            ]
    in
    List.map getCountForSlope slopes |> List.product


getCountForSlope : Vector -> Int
getCountForSlope slope =
    getRoute slope (Vector 0 0) "" parsedData |> getTreeCount


getRoute : Vector -> Vector -> String -> List String -> String
getRoute slope point route lines =
    case lines of
        [] ->
            route

        line :: remainingLines ->
            let
                newRoute =
                    route ++ getNthChar point.x line

                newPoint =
                    { point | x = point.x + slope.x }

                newLines =
                    List.drop (slope.y - 1) remainingLines
            in
            getRoute slope newPoint newRoute newLines


getTreeCount : String -> Int
getTreeCount route =
    String.length (String.replace "." "" route)


getNthChar : Int -> String -> String
getNthChar n line =
    let
        index =
            modBy (String.length line) n
    in
    String.slice index (index + 1) line
