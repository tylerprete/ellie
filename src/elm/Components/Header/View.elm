module Components.Header.View
    exposing
        ( Context
        , SaveOption(..)
        , view
        )

import Html exposing (Html, header, h1, button, div, text, span)
import Html.Events exposing (onClick)
import Html.Attributes exposing (disabled)
import Shared.Icons as Icons
import Components.Header.Classes exposing (..)


viewButton : msg -> Bool -> String -> Html msg -> Html msg
viewButton msg enabled content icon =
    button
        [ class [ Button ]
        , disabled <| not enabled
        , onClick msg
        ]
        [ span [ class [ ButtonIcon ] ] [ icon ]
        , span [] [ text content ]
        ]


viewSaveButton : msg -> SaveOption -> Bool -> Html msg
viewSaveButton msg saveOption enabled =
    case saveOption of
        Save ->
            viewButton msg enabled "Save" Icons.cloudOutline

        Update ->
            viewButton msg enabled "Update" Icons.cloudOutline

        Fork ->
            viewButton msg enabled "Fork" Icons.forkRepo


type SaveOption
    = Save
    | Update
    | Fork


type alias Context msg =
    { compileButtonEnabled : Bool
    , saveButtonEnabled : Bool
    , saveButtonOption : SaveOption
    , onSave : msg
    , onCompile : msg
    }


view : Context msg -> Html msg
view context =
    header [ class [ Header ] ]
        [ div [ class [ Logo ] ]
            [ h1 [ class [ LogoText ] ] [ text "Ellie" ]
            ]
        , viewButton context.onCompile context.compileButtonEnabled "Compile" Icons.playOutline
        , viewSaveButton context.onSave context.saveButtonOption context.saveButtonEnabled
        ]