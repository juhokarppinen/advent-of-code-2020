module Day5 exposing (getRange, heading, solutions)

import Data.Day5 exposing (data)


parsedData : List String
parsedData =
    String.split "\n" data


heading : String
heading =
    "Day 5: Binary Boarding"


solutions : List String
solutions =
    List.map String.fromInt [ part1, part2 ]


part1 : Int
part1 =
    case List.maximum seatIds of
        Nothing ->
            0

        Just value ->
            value


part2 : Int
part2 =
    getFirstNonConsecutive <| List.sort seatIds


seatIds : List Int
seatIds =
    List.map getSeatId parsedData


getFirstNonConsecutive : List Int -> Int
getFirstNonConsecutive ids =
    case ids of
        a :: b :: cs ->
            if a + 1 /= b then
                a + 1

            else
                getFirstNonConsecutive (b :: cs)

        _ ->
            0


getSeatId : String -> Int
getSeatId line =
    let
        ( rowId, columnId ) =
            getRowAndCol line

        row =
            binarySearch ( 0, 127 ) rowId

        column =
            binarySearch ( 0, 7 ) columnId
    in
    row * 8 + column


getRowAndCol : String -> ( List Char, List Char )
getRowAndCol seat =
    ( String.left 7 seat |> String.toList, String.dropLeft 7 seat |> String.toList )


binarySearch : ( Int, Int ) -> List Char -> Int
binarySearch range directions =
    case directions of
        d :: ds ->
            binarySearch (getRange range d) ds

        [] ->
            Tuple.first range


getRange : ( Int, Int ) -> Char -> ( Int, Int )
getRange ( min, max ) direction =
    let
        diff =
            (max - min) // 2 + 1

        selectUpperHalf =
            List.member direction [ 'B', 'R' ]
    in
    if selectUpperHalf == True then
        ( min + diff, max )

    else
        ( min, max - diff )
