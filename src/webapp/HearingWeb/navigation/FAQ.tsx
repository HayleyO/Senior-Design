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
            <FAQuestion
                header={"What does HearRing do with my data?"}
                body={"HearRING doesn't store any of your data. All your information stays on your device, and all recording data is deleted after one minute. Sound recordings are only used to provide transcripts and vibrations."} />
            <FAQuestion
                header={"Is there a HearRING Android app?"}
                body={"Unfortunately, there is no Android version of HearRING. Android smartwatches don't have the microphone capability needed for our recording."} />
        </div>
    );
}
export default FAQ;
