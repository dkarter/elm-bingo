module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trim)

initialModel =
  {
    entries =
      [
        newEntry "Future-Proof" 200 1,
        newEntry "Agile" 400 2,
        newEntry "Data Science" 230 3,
        newEntry "In the Cloud" 800 4
      ]
  }

title message times =
  message ++ " "
    |> toUpper
    |> repeat times
    |> trim
    |> text

pageHeader =
  h1 [ id "logo", class "classy" ] [ title "Bingo!" 3 ]

pageFooter =
  footer []
    [
      a [ href "http://doriankarter.com" ]
        [ text "Dorian Karter" ]
    ]

newEntry phrase points id =
  {
    phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }

entryItem entry =
  li []
    [
      span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ]
    ]

entryList entries =
  ul [] (List.map entryItem entries)

view model =
  div [ id "container" ]
    [
      pageHeader,
      entryList model.entries,
      pageFooter
    ]

main =
  view initialModel
