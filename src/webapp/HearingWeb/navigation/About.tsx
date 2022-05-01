import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"
import { AutomaticPrefetchPlugin } from "webpack";

declare var require: any
var React = require('react');

function About() {
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab1 }}>
            <Header style={{ width: "100%" }} />

            <div style={{ width: "100%", textAlign: "center" }}>
                <div className="pageHeader">About hearRING</div>
                <div className="pagePanel">
                <div className="indentedBodyText">
                    <p>hearRING is an iOS app and connected Apple Watch app with the goal of connecting hearing-impaired users to their surroundings.
                        Whether someone is yelling at you, a car is driving by, or a dog is barking, our hearRING watch app will vibrate to get your attention.</p>
                    <p>Unfortunately, we live in a world where not everyone knows sign language.
                        hearRING's goal is to overcome obstacles to communication by providing a transcript of conversations - like closed captions for everyday life.
                        The Listening feature is powered by artificial intelligence to bring you a real-time conversion of sounds into text, and the Speak feature allows you to reply through your phone.
                        </p>
                    <p>hearRING combines features into a one stop shop for all your accessibility needs: vibration, real-time transcript, text to speech, vibrating alarms, and customizable settings all in one straighforward app.
                        </p>
                </div>
                <div className="divider"/>
                <div className="subHeader" style={{ marginLeft: "25px" }}>About Us</div>
                <div style={{marginLeft:"50px"}} className="indentedBodyText">
                    <p>We're a group of six Computer Science seniors at Louisiana Tech University.</p>
                    <p>Hayley Owens is the co-project lead and the lead AI designer. With the goal of using AI to assist users and improve the world, she's a soon-to-be Ph.D. student at Tufts working in assisstive robotics. </p>
                    <p>Hannah Folkertsma is a co-project lead, app developer, and web developer. Outside of programming, she loves animals, fiber art, and listening to music on vinyl. </p>
                    <p>Ashley Palmer is one of our team's app developers, focusing on user experience and design. When she's not coding, she's reading Victorian novels for her other major (English literature) or writing her own fantasy novel. </p>
                    <p>Jason Marxsen is a software developer working with Bluetooth technologies, app security, TTS, and AI. He is currently in the process of getting multiple degrees in Neuroscience and Artificial Intelligence; in his spare time, he enjoys many activities from music writing to program creation, swimming/kayaking/boating, and obstacle races. </p>
                    <p>Eddie Redmann is an associate developer for the artificial intelligence used in this team as well as the team's primary optimizer and organizational reserve. In his free time, he enjoys hiking and biking, card games, and motor racing.</p>
                    <p>Tyler Lane is our QA department - our resident bug fixer and tester. He works in Information Technology. He enjoys biking, swimming, card games, and spending time with his dog. </p>
                </div>
                <div className="divider" />
                    <div className="subHeader" style={{ marginLeft: "25px" }}>Acknowledgements</div>
                    <div className="indentedBodyText" style={{ marginLeft: "50px" }}>
                    <p>Thank you to Dr. Jim Palmer, Mrs. Sylvia Schultz, Dr. Mary Caldorera-Moore, and the Louisiana Tech Computer Help Desk and Library for providing the devices we needed for this project. </p>
                    <p>Thank you to Jacob Hicks, Dr. Steven Madix, Dr. Mike O'Neal, and Kyle Prather for insight and feedback.</p>
                </div>
                </div>
                </div>
        </div>);
}

export default About;