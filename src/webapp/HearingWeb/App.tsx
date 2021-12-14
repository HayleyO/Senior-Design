declare var require: any

var React = require('react');
var ReactDOM = require('react-dom');

export class MainPage extends React.Component {
    render() {
        return (
                <div id="root">
                    <img src="images\logo.jpg" alt="heaRING logo"></img>
                </div>
        );
    }

}

ReactDOM.render(<MainPage />, document.getElementById('root'));