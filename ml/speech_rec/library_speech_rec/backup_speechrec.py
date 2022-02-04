import os
import random
import time
import pyaudio
import speech_recognition as sr

def recognize_speech_from_mic(recognizer, microphone):
    if not isinstance(recognizer, sr.Recognizer):
        raise TypeError("`recognizer` must be `Recognizer` instance")

    if not isinstance(microphone, sr.Microphone):
        raise TypeError("`microphone` must be `Microphone` instance")

    response = {
        "success": True,
        "error": None,
        "transcription": None
    }

    with microphone as source:
        recognizer.adjust_for_ambient_noise(source)
        audio_data = recognizer.listen(source)

    try:
        response["transcription"] = recognizer.recognize_google(audio_data)
    except sr.RequestError:
        # API was unreachable or unresponsive
        response["success"] = False
        response["error"] = "API unavailable"
    except sr.UnknownValueError:
        # speech was unintelligible
        response["error"] = "Unable to recognize speech"
    return response


if __name__ == "__main__":
    recognizer = sr.Recognizer()
    microphone = sr.Microphone()

    while True:
        #This does real time with some lag, but this is a good starting ground
        response = recognize_speech_from_mic(recognizer=recognizer, microphone=microphone)
        print(response["transcription"])