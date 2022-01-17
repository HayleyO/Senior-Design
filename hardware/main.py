import time
import board

DEBUG_LED = False
HAPTIC_CONTROLLER = True

# LED
if DEBUG_LED:
    import digitalio

    led = digitalio.DigitalInOut(board.LED)
    led.direction = digitalio.Direction.OUTPUT

# Haptic Controller
if HAPTIC_CONTROLLER:
    import busio
    import adafruit_drv2605

    i2c = busio.I2C(board.SCL, board.SDA)
    drv = adafruit_drv2605.DRV2605(i2c)
    sound_intensities = {
        "mild": adafruit_drv2605.Effect(1),
        "moderate": adafruit_drv2605.Effect(2),
        "severe": adafruit_drv2605.Effect(3),
    }

def check_sound(sound_intensity):
    drv.sequence[0] = sound_intensities[sound_intensity]
    drv.play()


if __name__ == "__main__":
    while True:
        if DEBUG_LED:
            led.value = True
            time.sleep(0.5)
            led.value = False
            time.sleep(0.5)
        if HAPTIC_CONTROLLER:
            check_sound("mild")
            check_sound("moderate")
            check_sound("severe")
