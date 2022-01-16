import { colors } from "../colors"
import "../styles.css"

declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

let tts = new SpeechSynthesisUtterance();
tts.lang = "en";
tts.volume = 0.5;

function Speech() {
    tts.text = (document.getElementById("texthere") as HTMLInputElement).value;
    window.speechSynthesis.speak(tts);
}

function Volume() {
    tts.volume = (document.getElementById("volslider") as HTMLInputElement).value as unknown as number;
}

function Pitch() {
    tts.pitch = (document.getElementById("pitchslider") as HTMLInputElement).value as unknown as number;
}
function Rate() {
    tts.rate = (document.getElementById("rateslider") as HTMLInputElement).value as unknown as number;
}

function SetVoiceList() {
    if (typeof speechSynthesis === 'undefined') {
        return;
    }
    var voiceBox = (document.getElementById("voice") as HTMLSelectElement);
    var voices = speechSynthesis.getVoices();

    if (voiceBox.length > voices.length) {
        var tmp, L = voiceBox.length - 1;
        for (tmp = L; tmp >= 0; tmp--) {
            voiceBox.remove(tmp);
        }
    } else if (voiceBox.length == voices.length) {
        return;
    }

    for (var i = 0; i < voices.length; i++) {
        var option = document.createElement('option');
        option.textContent = voices[i].name + ' (' + voices[i].lang + ')';

        if (voices[i].default) {
            option.textContent += ' --DEFAULT';
        }

        option.setAttribute('data-lang', voices[i].lang);
        option.setAttribute('data-name', voices[i].name);
        document.getElementById("voice").appendChild(option);
    }
}

function voiceUpdate(voice) {
    var voices = speechSynthesis.getVoices();
    var voiceBox = (document.getElementById("voice") as HTMLSelectElement);

    for (var i = 0; i < voices.length; i++) {
        var check = voices[i].name + " (" + voices[i].lang+")";
        if (voiceBox.value == check) {
            tts.voice = voices[i];
            return;
        }
    }
}

export class TextboxButtonsTTS extends React.Component {
    render() {
        return (
            <body onpageshow="SetVoiceList">
                <textarea rows="10" cols="60" name="textbox" id="texthere"></textarea>
                <p/>
                <button id="speak" onClick={Speech}>
                    Press to convert text to speech
                </button>
                <p/>
                <table style={{marginLeft:"auto", marginRight:"auto"}}>
                <tr>
                    <td>
                        <p>Volume</p>
                        <input id="volslider" type="range" defaultValue="0.5" min="0" max="1" step="0.1" onInput={Volume} />
                    </td>
                    <td>
                        <p>Pitch</p>
                        <input id="pitchslider" type="range" defaultValue="1" min="0" max="2" step="1" onInput={Pitch} />
                    </td>
                    <td>
                        <p>Rate</p>
                        <input id="rateslider" type="range" defaultValue="1" min="0.1" max="3" step="0.1" onInput={Rate}/> 
                    </td>
                </tr>
                </table>
                <p>Voice</p>
                <select id="voice" onClick={SetVoiceList} onChange={voiceUpdate} />
            </body>
        );
    }
}