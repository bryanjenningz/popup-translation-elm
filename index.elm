import Html exposing (div, text, span)
import Html.App exposing (beginnerProgram)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style)

textPairs =
  [ {shownText = "你好", popupText = Just "[ni3hao3]: Hello"}
  , {shownText = "，", popupText = Nothing}
  , {shownText = "我", popupText = Just "[wo3]: I, me"}
  , {shownText = "不错", popupText = Just "[bu4cuo4]: Not bad"}
  ]

selectedStyle =
  style
    [ ("background", "cyan")
    , ("position", "relative")
    ]

popupStyle =
  style
    [ ("position", "absolute")
    , ("top", "20px")
    , ("background", "#aaa")
    ]

main =
  beginnerProgram
    { model = model
    , view = view
    , update = update
    }

type Msg = PopupIndex Int

model = -1

view model =
  div []
    [ div [] <| List.indexedMap (viewTextPair model) textPairs ]

viewTextPair model i textPair =
  let
    selected =
      i == model && textPair.popupText /= Nothing
  in
    span []
      [ span
          [ onClick (PopupIndex <| if model == i then -1 else i)
          , if selected then selectedStyle else style []
          ]
          [ text textPair.shownText ]
      , span
          [ popupStyle ]
          [ text <|
              case textPair.popupText of
                Just popupText ->
                  if selected then popupText else ""
                Nothing ->
                  ""
          ]
      ]

update msg model =
  case msg of
    PopupIndex index ->
      index
