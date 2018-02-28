module Main exposing (main)

import Parent
import Html exposing (Html)


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Program", Cmd.none )


type Msg
    = NoOp


view : Model -> Html Msg
view model =
    Html.div []
        [ Html.text model ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never (Parent.Model Model) (Parent.Msg Msg)
main =
    Parent.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
