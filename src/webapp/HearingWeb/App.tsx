import { table } from "console";
import { Header } from "./components/Header";
import { TextboxButtonsTTS } from "./components/TextboxButtonsTTS";

declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

function click() {
    alert('Clicked');
}

export class Start extends React.Component {
    render() {
        return (
            <div id="root">
                <Header style={{ width: "100%" }} />
                <TextboxButtonsTTS/>
            </div>
                
        );
    }

}

ReactDOM.render(<Start/>, document.getElementById('root'));