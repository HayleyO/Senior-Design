import { Header } from "../components/Header";
import "../styles.css"

declare var require: any
var React = require('react');

function About() {
    return (
        <div>
            <Header style={{ width: "100%" }} />
            <div>about page</div>
    </div>);
}

export default About;