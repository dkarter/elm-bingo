module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String exposing (toUpper, repeat, trim)


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

entryList =
  ul []
    [
      entryItem (newEntry "Future-Proof" 200 1),
      entryItem (newEntry "Agile" 400 2),
      entryItem (newEntry "Data Science" 230 3),
      entryItem (newEntry "In the Cloud" 800 4)
    ]

view =
  div [ id "container" ]
    [
      pageHeader,
      entryList,
      pageFooter
    ]

main =
  view
