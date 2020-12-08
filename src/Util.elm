module Util exposing (parseIntList, splitTwo)

splitTwo : String -> String -> ( String, String )
splitTwo separator string =
    case String.split separator string of
        first :: last :: rest ->
            ( first, last )

        _ ->
            ( "", "" )


parseIntList : List Int -> List String -> List Int
parseIntList intList stringList =
    case stringList of
        [] ->
            intList

        x :: xs ->
            case String.toInt x of
                Nothing ->
                    parseIntList intList xs

                Just value ->
                    parseIntList (List.append intList [ value ]) xs


