# gpu_fan_control
Control GPU fans using bash.

## Motivation
My GPU fan controller was playing up, constantly running one fan full blast. This script turns off PWM until a certain temperature (60 degrees) and re-enables PWM until the temperature cools. Enabling PWM spins up the fans to cool the GPU.

## Install
Move the script into place

## Usage
`sudo bash fans.sh`
