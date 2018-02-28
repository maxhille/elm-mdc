module Button exposing (..)

import Html
import Material
import Material.Button as Button


type alias Model =
    { mdl : Material.Model
    }


initModel : Model
initModel =
    { mdl = Material.defaultModel
    }


type Msg
    = NoOp
    | MaterialMsg (Material.Msg Msg)


main : Program Never Model Msg
main =
    Html.program
    { init = init
    , subscriptions = subscriptions
    , update = update
    , view = view
    }

init : ( Model, Cmd Msg )
init =
    ( initModel, Material.init MaterialMsg )


subscriptions : Model -> Sub Msg
subscriptions model =
    Material.subscriptions MaterialMsg model


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        MaterialMsg msg_ ->
            Material.update MaterialMsg msg_ model

view : Model -> Html.Html Msg
view model =
    Html.div []
        [
          Button.render MaterialMsg [0] model.mdl
              []
              [ Html.text "Click me!" ]
        ]
        |> Material.top

