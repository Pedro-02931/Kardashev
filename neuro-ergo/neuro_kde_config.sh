#!/bin/bash

# Cria os diretórios necessários, caso não existam
mkdir -p ~/.config/latte
mkdir -p ~/.local/share/color-schemes

# Escreve o conteúdo do arquivo ~/.config/kwinrc
cat <<EOF > ~/.config/kwinrc
[Compositing]
AnimationSpeed=1.2
Enabled=true
GLPreferBufferSwap=c
GLScene=false
LatencyPolicy=low
MaxFPS=144
RefreshRate=144
VSyncMode=OnlyWhenCheap

[Plugins]
blurEnabled=true
contrastEnabled=true
desktopchangeosdEnabled=false
kwin4_effect_fadeEnabled=true
kwin4_effect_scaleEnabled=true
kwin4_effect_squashEnabled=false

[Effect-PresentWindows]
Duration=160

[Effect-Slide]
Duration=220

[Effect-Fade]
Duration=120

[Effect-Scale]
Duration=180
EOF

# Escreve o conteúdo do arquivo ~/.config/kglobalshortcutsrc
cat <<EOF > ~/.config/kglobalshortcutsrc
[ActivityManager]
_switch-to-activity-f8734d3a-7c5a-40c3-832d-028d42fe219e=none,none,Switch to NeuroFocus Activity

[kwin]
Expose=Meta+,,Expose
ExposeAll=Meta+Up,Meta+Up,ExposeAll
ExposeClass=Meta+Down,none,ExposeClass
Switch Window Down=Meta+J,none,Switch Window Down
Switch Window Left=Meta+H,none,Switch Window Left
Switch Window Right=Meta+L,none,Switch Window Right
Switch Window Up=Meta+K,none,Switch Window Up
Window Close=Meta+Q,none,Close Window
Window Maximize=Meta+Return,none,Maximize Window
Window Quick Tile Bottom=Meta+Shift+J,none,Quick Tile Window to Bottom
Window Quick Tile Left=Meta+Shift+H,none,Quick Tile Window to Left
Window Quick Tile Right=Meta+Shift+L,none,Quick Tile Window to Right
Window Quick Tile Top=Meta+Shift+K,none,Quick Tile Window to Top
EOF

# Escreve o conteúdo do arquivo ~/.config/plasmarc
cat <<EOF > ~/.config/plasmarc
[Theme]
name=neuro-plasma
colorScheme=NeuroBauhaus
iconTheme=Papirus-Dark
font=SF Pro Display,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,0,1
EOF

# Escreve o conteúdo do arquivo ~/.config/latte/NeuroLayout.layout.latte
cat <<EOF > ~/.config/latte/NeuroLayout.layout.latte
{
  "containments": [
    {
      "applets": [
        {
          "plugin": "org.kde.plasma.kickoff",
          "config": {
            "icon": "neuro-logo",
            "popupHeight": 640,
            "popupWidth": 480
          }
        },
        {"plugin": "org.kde.plasma.pager"},
        {"plugin": "org.kde.plasma.taskmanager"},
        {
          "plugin": "org.kde.plasma.systemtray",
          "config": {
            "shownItems": ["networkmanager","bluetooth","audio"]
          }
        }
      ],
      "config": {
        "alignment": "center",
        "animations": 130,
        "duration": 220,
        "hoverEnabled": true,
        "shadowColor": "#00ffc3",
        "thickness": 42
      },
      "location": 3
    }
  ],
  "metadata": {
    "author": "NeuroDesktop",
    "version": "3.0"
  }
}
EOF

# Escreve o conteúdo do arquivo ~/.config/kwincompositorrc
cat <<EOF > ~/.config/kwincompositorrc
[Compositing]
AnimationSpeed=1.2
Backend=XRender
Enabled=true
GLPreferBufferSwap=c
GLScene=false
LatencyPolicy=low
MaxFPS=144
RefreshRate=144
VSyncMode=OnlyWhenCheap

[Effect-Blur]
NoiseAmount=0.03
NoiseStrength=3
Saturation=1.5

[Effect-Contrast]
Contrast=0.15
Intensity=1.25
Saturation=1.1
EOF

# Escreve o conteúdo do arquivo ~/.local/share/color-schemes/NeuroBauhaus.colors
cat <<EOF > ~/.local/share/color-schemes/NeuroBauhaus.colors
[Colors:View]
BackgroundAlternate=27,29,32
BackgroundNormal=33,36,40
DecorationFocus=0,255,195
DecorationHover=40,150,200
ForegroundActive=255,255,255
ForegroundInactive=150,150,150
ForegroundLink=0,200,255
ForegroundNegative=255,80,80
ForegroundNeutral=200,200,0
ForegroundNormal=232,232,232
ForegroundPositive=0,255,100
ForegroundVisited=200,0,255

[Colors:Window]
BackgroundAlternate=27,29,32
BackgroundNormal=33,36,40
DecorationFocus=0,255,195
DecorationHover=40,150,200
ForegroundActive=255,255,255
ForegroundInactive=150,150,150
ForegroundNormal=232,232,232

[General]
ColorScheme=NeuroBauhaus
Name=NeuroBauhaus
EOF

echo "Configuração Neuro-Visual aplicada. Reinicie o Plasma para ver as mudanças."