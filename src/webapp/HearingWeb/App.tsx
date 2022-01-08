import { table } from "console";
import { Header } from "./components/Header";

declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

export class Start extends React.Component {
    render() {
        return (
            <div id="root">
                <Header style={{width:"100%"}}/>
            </div>
                
        );
    }

}

ReactDOM.render(<Start/>, document.getElementById('root'));