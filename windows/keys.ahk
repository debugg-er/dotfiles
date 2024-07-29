#MaxHotkeysPerInterval 500

Capslock::Esc
Esc::`

RAlt::
Hotkey, e, label_e, On
Hotkey, d, label_d, On
Hotkey, s, label_s, On
Hotkey, f, label_f, On
return

RAlt Up::
Hotkey, e, Off
Hotkey, d, Off
Hotkey, s, Off
Hotkey, f, Off
return

label_e:
Send {Up}
return

label_d:
Send {Down}
return

label_s:
Send {Left}
return

label_f:
Send {Right}
return
