import random
import time
import pyaudio
import speech_recognition as sr


def recognize_speech_from_mic(recognizer, microphone):
    try:
        with microphone as source:
            recognizer.adjust_for_ambient_noise(source)
            audio_data = recognizer.record(source, duration=5)

        response = recognizer.recognize_google(audio_data)
    except Exception as err:
        print("ERROR: " + err)
    return response


if __name__ == "__main__":
    recognizer = sr.Recognizer()
    microphone = sr.Microphone()

    while True:
        #This does real time with some lag, but this is a good starting ground
        response = recognize_speech_from_mic(recognizer=recognizer, microphone=microphone)
        print(response)