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
        [ text "Dorian Karter Home Page" ]
    ]

entryItem phrase points =
  li []
    [
      span [ class "phrase" ] [ text phrase ],
      span [ class "points" ] [ text (toString points) ]
    ]

entryList =
  ul []
    [
      entryItem "Future-Proof" 200,
      entryItem "Agile" 400,
      entryItem "Reactive" 230,
      entryItem "Pragmatic" 800
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
