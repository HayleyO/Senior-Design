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
                qid={0}
                header={"What does hearRING do with my data?"}
                body={"hearRING doesn't store any of your data. All your information stays on your device, and all recording data is deleted after one minute. Sound recordings are only used to provide transcripts and vibrations."} />
            <FAQuestion
                qid={1}
                header={"Is there a hearRING Android app?"}
                body={"Unfortunately, there is no Android version of hearRING. Android smartwatches don't have the microphone capability needed for our recording."} />
            <FAQuestion
                qid={2}
                header={"What are the settings for?"}
                body={
                    `Settings allow you to choose the decibel thresholds for vibrations.<br>
                     The default presets are chosen based on common locations, like restaurants. By using the restaurant preset, your HearRING app will 
                     ignore the higher levels of background noise, and make it easier to detect when you're being spoken to.<br>
                     Even if you're using a preset, you can adjust the settings on your watch. If you think the watch is vibrating too much, 
                        you can increase the thresholds. If it isn't vibrating enough, you can decrease the thresholds.
                    `} />
            <FAQuestion
                qid={3}
                header={"Do I need cellular data on my Apple Watch to use hearRING?"}
                body={`No! <br>
                        hearRING works using the Bluetooth connection between your Apple Watch and iPhone, no cellular data required! `} />
            <FAQuestion
                qid={4}
                header={"Why isn't the app picking up my voice accurately?"}
                body={`Artificial intelligence isn't perfect, so there will likely be an incorrect word every so often. If errors are common, try enunciating your words as clearly as possible. `} />
            <FAQuestion
                qid={5}
                header={"Can I change the text size?"}
                body={`If the text size of the hearRING app isn't to your liking, you can change the font size in your iPhone's settings. hearRING will adjust accordingly. <br>
                        To find the text size settings, go to "Accessibility" > "Display & Text Size" in your iPhone settings.`} />
            <FAQuestion
                qid={6}
                header={"How can I change to light or dark mode?"}
                body={`hearRING reflects your iPhone's settings. To change between light and dark mode on your iPhone, find "Display and Brightness" in your Settings app.`} />
        </div>
    );
}
export default FAQ;
