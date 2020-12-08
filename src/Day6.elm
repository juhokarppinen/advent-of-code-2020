module Day6 exposing (heading, solutions)

import Data.Day6 exposing (data)
import Set


parsedData : List String
parsedData =
    String.split "\n\n" data


heading : String
heading =
    "Day 6: Custom Customs"


solutions : List String
solutions =
    List.map String.fromInt [ part1, part2 ]


part1 : Int
part1 =
    let
        getUniqueCharCount =
            String.words >> String.join "" >> String.toList >> Set.fromList >> Set.size
    in
    List.map getUniqueCharCount parsedData |> List.sum


part2 : Int
part2 =
    let
        getCommonChars : List String -> Set.Set Char
        getCommonChars words =
            case List.head words of
                Nothing ->
                    Set.empty

                Just head ->
                    let
                        intersect : List Char -> Set.Set Char -> Set.Set Char
                        intersect list set =
                            Set.intersect (Set.fromList list) set

                        initialValue =
                            String.toList head |> Set.fromList

                        wordsAsCharLists =
                            List.map String.toList words
                    in
                    List.foldl intersect initialValue wordsAsCharLists
    in
    List.map (String.words >> getCommonChars >> Set.size) parsedData |> List.sum
