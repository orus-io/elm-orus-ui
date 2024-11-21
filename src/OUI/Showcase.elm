module OUI.Showcase exposing (addPages)

{-| Provides pages for a OUI.Explorer

@docs addPages

-}

import OUI.Explorer as Explorer exposing (Explorer)
import OUI.Showcase.Badge as Badge
import OUI.Showcase.Buttons as Buttons
import OUI.Showcase.Checkbox as Checkbox
import OUI.Showcase.Colors as Colors
import OUI.Showcase.Dialog as Dialog
import OUI.Showcase.Dividers as Dividers
import OUI.Showcase.MenuButtons as MenuButtons
import OUI.Showcase.Menus as Menus
import OUI.Showcase.Navigation as Navigation
import OUI.Showcase.Progress as Progress
import OUI.Showcase.RadioButtons as RadioButtons
import OUI.Showcase.Slider as Slider
import OUI.Showcase.Switches as Switches
import OUI.Showcase.Tabs as Tabs
import OUI.Showcase.TextFields as TextFields
import OUI.Showcase.Typography as Typography
import Spa
import Spa.PageStack


{-| add the default showcase pages to a Explorer
-}
addPages :
    Explorer themeExt current previous currentMsg previousMsg
    ->
        Explorer
            themeExt
            ()
            (Spa.PageStack.Model
                Spa.SetupError
                Navigation.Model
                (Spa.PageStack.Model
                    Spa.SetupError
                    MenuButtons.Model
                    (Spa.PageStack.Model
                        Spa.SetupError
                        TextFields.Model
                        (Spa.PageStack.Model
                            Spa.SetupError
                            Tabs.Model
                            (Spa.PageStack.Model
                                Spa.SetupError
                                Switches.Model
                                (Spa.PageStack.Model
                                    Spa.SetupError
                                    Slider.Model
                                    (Spa.PageStack.Model
                                        Spa.SetupError
                                        RadioButtons.Model
                                        (Spa.PageStack.Model
                                            Spa.SetupError
                                            ()
                                            (Spa.PageStack.Model
                                                Spa.SetupError
                                                ()
                                                (Spa.PageStack.Model
                                                    Spa.SetupError
                                                    ()
                                                    (Spa.PageStack.Model
                                                        Spa.SetupError
                                                        Checkbox.Model
                                                        (Spa.PageStack.Model
                                                            Spa.SetupError
                                                            ()
                                                            (Spa.PageStack.Model
                                                                Spa.SetupError
                                                                ()
                                                                (Spa.PageStack.Model
                                                                    Spa.SetupError
                                                                    ()
                                                                    (Spa.PageStack.Model
                                                                        Spa.SetupError
                                                                        Colors.Model
                                                                        (Spa.PageStack.Model
                                                                            Spa.SetupError
                                                                            current
                                                                            previous
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
            (Explorer.BookMsg ())
            (Spa.PageStack.Msg
                Explorer.Route
                (Explorer.BookMsg Navigation.Msg)
                (Spa.PageStack.Msg
                    Explorer.Route
                    (Explorer.BookMsg MenuButtons.Msg)
                    (Spa.PageStack.Msg
                        Explorer.Route
                        (Explorer.BookMsg TextFields.Msg)
                        (Spa.PageStack.Msg
                            Explorer.Route
                            (Explorer.BookMsg Tabs.Msg)
                            (Spa.PageStack.Msg
                                Explorer.Route
                                (Explorer.BookMsg Switches.Msg)
                                (Spa.PageStack.Msg
                                    Explorer.Route
                                    (Explorer.BookMsg Slider.Msg)
                                    (Spa.PageStack.Msg
                                        Explorer.Route
                                        (Explorer.BookMsg RadioButtons.Msg)
                                        (Spa.PageStack.Msg
                                            Explorer.Route
                                            (Explorer.BookMsg ())
                                            (Spa.PageStack.Msg
                                                Explorer.Route
                                                (Explorer.BookMsg ())
                                                (Spa.PageStack.Msg
                                                    Explorer.Route
                                                    (Explorer.BookMsg ())
                                                    (Spa.PageStack.Msg
                                                        Explorer.Route
                                                        (Explorer.BookMsg
                                                            Checkbox.Msg
                                                        )
                                                        (Spa.PageStack.Msg
                                                            Explorer.Route
                                                            (Explorer.BookMsg ())
                                                            (Spa.PageStack.Msg
                                                                Explorer.Route
                                                                (Explorer.BookMsg
                                                                    ()
                                                                )
                                                                (Spa.PageStack.Msg
                                                                    Explorer.Route
                                                                    (Explorer.BookMsg
                                                                        ()
                                                                    )
                                                                    (Spa.PageStack.Msg
                                                                        Explorer.Route
                                                                        (Explorer.BookMsg
                                                                            Colors.Msg
                                                                        )
                                                                        (Spa.PageStack.Msg
                                                                            Explorer.Route
                                                                            currentMsg
                                                                            previousMsg
                                                                        )
                                                                    )
                                                                )
                                                            )
                                                        )
                                                    )
                                                )
                                            )
                                        )
                                    )
                                )
                            )
                        )
                    )
                )
            )
addPages =
    Explorer.category "Styles"
        >> Explorer.addBook Colors.book
        >> Explorer.addBook Typography.book
        >> Explorer.category "Basics"
        >> Explorer.addBook Badge.book
        >> Explorer.addBook Buttons.book
        >> Explorer.addBook Checkbox.book
        >> Explorer.addBook Dividers.book
        >> Explorer.addBook Menus.book
        >> Explorer.addBook Progress.book
        >> Explorer.addBook RadioButtons.book
        >> Explorer.addBook Slider.book
        >> Explorer.addBook Switches.book
        >> Explorer.addBook Tabs.book
        >> Explorer.addBook TextFields.book
        >> Explorer.category "Complex"
        >> Explorer.addBook MenuButtons.book
        >> Explorer.addBook Navigation.book
        >> Explorer.addBook Dialog.book
