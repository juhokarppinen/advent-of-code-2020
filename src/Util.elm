module Util exposing (parseIntList)

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


