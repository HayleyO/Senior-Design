import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"
import { FAQuestion } from "../components/FAQuestion"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');

function FAQ() {
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab3 }}>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">Frequently Asked Questions</div>
            <FAQuestion header={"What does HearRing do with my data?"}/>
        </div>
    );
}
export default FAQ;
