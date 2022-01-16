import { colors } from "../colors"
import "../styles.css"

declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

export class SpeechToTextOutput extends React.Component {
    render() {
        return (
            <body>
                <textarea rows="10" cols="60" name="textbox" id="texthere" />
            </body>
            )
    }
}