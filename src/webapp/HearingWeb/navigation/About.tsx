import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"

declare var require: any
var React = require('react');

function About() {
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab4 }}>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">About hearRING</div>
        </div>);
}

export default About;