module Parent exposing (program, Model, Msg)

import Html exposing (Html, div, text)


type alias Model childModelType =
    { decor : String
    , childModel : childModelType
    }


init : ( childModelType, Cmd childMsgType ) -> ( Model childModelType, Cmd (Msg childMsgType) )
init childInit =
    ( { decor = "Hello"
      , childModel = Tuple.first childInit
      }
    , Cmd.map ChildMsg (Tuple.second childInit)
    )


type Msg childMsgType
    = ChildMsg childMsgType


view : (childModelType -> Html childMsgType) -> Model childModelType -> Html (Msg childMsgType)
view childView model =
    div []
        [ text model.decor
        , Html.map ChildMsg (childView model.childModel)
        ]


update : (childMsgType -> childModelType -> ( childModelType, Cmd childMsgType )) -> Msg childMsgType -> Model childModelType -> ( Model childModelType, Cmd (Msg childMsgType) )
update childUpdate msg model =
    case msg of
        ChildMsg childMsg ->
            let
                ( childModel, childCmd ) =
                    childUpdate childMsg model.childModel
            in
                ( { model | childModel = childModel }, Cmd.map ChildMsg childCmd )


subscriptions : (childModelType -> Sub childMsgType) -> Model childModelType -> Sub (Msg childMsgType)
subscriptions childSubscriptions model =
    Sub.map ChildMsg (childSubscriptions model.childModel)


program :
    { init : ( childModelType, Cmd childMsgType )
    , update : childMsgType -> childModelType -> ( childModelType, Cmd childMsgType )
    , subscriptions : childModelType -> Sub childMsgType
    , view : childModelType -> Html childMsgType
    }
    -> Program Never (Model childModelType) (Msg childMsgType)
program child =
    Html.program
        { init = init child.init
        , view = view child.view
        , update = update child.update
        , subscriptions = subscriptions child.subscriptions
        }
