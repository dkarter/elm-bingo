module Bingo where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Address)
import StartApp

import String exposing (toUpper, repeat, trim)

-- MODEL
type alias Entry =
  {
    id: Int,
    phrase: String,
    wasSpoken: Bool,
    points: Int
  }

type alias Model =
  { entries: List Entry }

initialModel : Model
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

-- UPDATE
type Action =
  NoOp | Sort | Delete Int | Mark Int

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

    Sort->
      { model | entries <- List.sortBy .points model.entries }

    Delete id ->
      let remainingEntries =
        List.filter (\e -> e.id /= id) model.entries
      in
        { model | entries <- remainingEntries }

    Mark id ->
      let updateEntry e =
        if e.id == id then { e | wasSpoken <- (not e.wasSpoken) } else e
      in
        { model | entries <- List.map updateEntry model.entries }

-- VIEW
title : String -> Int -> Html
title message times =
  message ++ " "
    |> toUpper
    |> repeat times
    |> trim
    |> text

pageHeader : Html
pageHeader =
  h1 [ id "logo", class "classy" ] [ title "Bingo!" 3 ]

pageFooter : Html
pageFooter =
  footer []
    [
      a [ href "http://doriankarter.com" ]
        [ text "Dorian Karter" ]
    ]

newEntry : String -> Int -> Int -> Entry
newEntry phrase points id =
  {
    phrase = phrase,
    points = points,
    wasSpoken = False,
    id = id
  }

totalPoints : List Entry -> Int
totalPoints entries =
  entries
    |> List.filter .wasSpoken
    |> List.map .points
    |> List.sum

totalItem : Int -> Html
totalItem total = 
  li 
    [ class "total" ]
    [ 
      span [ class "label" ] [ text "Total" ],
      span [ class "points" ] [ text (toString total) ]
    ]

entryItem : Address Action -> Entry -> Html
entryItem address entry =
  li 
    [
      onClick address (Mark entry.id),
      classList [ ("highlight", entry.wasSpoken) ]
    ]
    [
      span [ class "phrase" ] [ text entry.phrase ],
      span [ class "points" ] [ text (toString entry.points) ],
      deleteButton address entry.id
    ]

entryList : Address Action -> List Entry -> Html
entryList address entries =
  let
    entryItems = List.map ( entryItem address ) entries
    items = entryItems ++ [ totalItem (totalPoints entries) ]
  in
    ul [] items

sortButton : Address Action -> Html
sortButton address =
  button 
    [ class "sort", onClick address Sort ] 
    [ text "Sort" ]

deleteButton : Address Action -> Int -> Html
deleteButton address id =
  button 
    [ class "delete", onClick address ( Delete id ) ] 
    []

view : Address Action -> Model -> Html
view address model =
  div [ id "container" ]
    [
      pageHeader,
      entryList address model.entries,
      sortButton address,
      pageFooter
    ]

-- WIRE IT ALL TOGETHER

main : Signal Html
main =
  StartApp.start
    {
      model = initialModel,
      update = update,
      view = view
    }
