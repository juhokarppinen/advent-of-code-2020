module Day4 exposing (heading, solutions)

import Data.Day4 exposing (data)
import Maybe exposing (withDefault)
import Set
import Util


parsedData : List String
parsedData =
    String.split "\n\n" data


heading : String
heading =
    "Day 4: Passport Processing"


solutions : List String
solutions =
    List.map String.fromInt [ part1, part2 ]


part1 : Int
part1 =
    let
        isValid chunk =
            let
                hasCid =
                    String.contains "cid:" chunk

                fieldCount =
                    Util.countChars ":" chunk
            in
            fieldCount == 8 || (fieldCount == 7 && hasCid == False)
    in
    List.map isValid parsedData |> List.filter (\b -> b == True) |> List.length


part2 : Int
part2 =
    let
        isValid chunk =
            let
                fields =
                    String.words chunk

                hasCid =
                    String.contains "cid:" chunk

                fieldCount =
                    List.length fields

                areFieldsValid =
                    List.all isValidFieldValue fields
            in
            areFieldsValid && (fieldCount == 8 || (fieldCount == 7 && hasCid == False))
    in
    List.map isValid parsedData |> List.filter (\b -> b == True) |> List.length


isValidFieldValue : String -> Bool
isValidFieldValue field =
    let
        ( key, value ) =
            Util.splitTwo ":" field

        intValue =
            Util.toInt value
    in
    case key of
        "byr" ->
            intValue >= 1920 && intValue <= 2002

        "iyr" ->
            intValue >= 2010 && intValue <= 2020

        "eyr" ->
            intValue >= 2020 && intValue <= 2030

        "hgt" ->
            let
                unit =
                    String.right 2 value

                height =
                    String.dropRight 2 value |> Util.toInt
            in
            case unit of
                "in" ->
                    height >= 59 && height <= 76

                "cm" ->
                    height >= 150 && height <= 193

                _ ->
                    False

        "hcl" ->
            let
                head =
                    String.left 1 value

                tail =
                    String.dropLeft 1 value
            in
            head == "#" && String.length tail == 6 && String.all Char.isHexDigit tail

        "ecl" ->
            let
                validColors =
                    Set.fromList [ "amb", "blu", "brn", "gry", "grn", "hzl", "oth" ]
            in
            Set.member value validColors

        "pid" ->
            String.all Char.isDigit value && String.length value == 9

        "cid" ->
            True

        _ ->
            False
