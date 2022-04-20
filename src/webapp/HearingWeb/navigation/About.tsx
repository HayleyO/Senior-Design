import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"
import { AutomaticPrefetchPlugin } from "webpack";

declare var require: any
var React = require('react');

function About() {
    return (
        <div className="pageBackground" style={{backgroundColor: colors.headertab4}}>
            <Header style={{ width: "100%" }} />
            <div style={{ width: "100%", textAlign: "center" }}>
                <div className="pageHeader">About HearRING</div>
                <div className="subHeader">subheader</div>
                <div className="bodyText">
                    <p>'HearRING is an iOS app and connected Apple Watch app with the goal of connecting hard of hearing people to their surroundings.
                        Whether someone is yelling at you, a car is driving by, or a dog is barking, our HearRING watch app will vibrate to get the wearer's attention</p>
                    <p>Unfortunately, we live in a world where not everyone knows sign language.
                        HearRING's goal is to overcome obstacles to communication by providing a transcript of conversations - like closed captions for everyday life.
                        The Listening feature is powered by artificial intelligence to bring you a real-time conversion of sounds into text, and the Speak feature allows you to reply through your phone.
                    </p>
                </div>
                <div className="pageHeader">About Us</div>
                <div className="bodyText">
                    <p>We're a group of six Computer Science seniors at Louisiana Tech University.</p>
                    <p>Hayley Owens is awesome, cool, and has worked at NASA. She intends to work in the field of artificial intelligence and will definitely succeed because she's ambitious and deeply motivated.</p>
                    <p>Hannah Folkertsma is awesome, cool, and has worked at IBM. She is an amazing frontend developer with a passion for web design and making things look pretty.</p>
                    <p>Ashley Palmer is awesome, cool, and a double major in Computer Science and English. She has no idea what she wants to do with her life other than write fantasy novels, but also enjoys web design and digital art.</p>
                    <p>Jason Marxsen is awesome, cool, and has a passion for neuroscience and artificial intelligence. He hopes to use artificial intelligence to analyze the brain and better understand the causes of mental illness.</p>
                    <p>Eddie Redmann is awesome, cool, and an aspiring data scientist. He's smart, driven, and analytical. He is our local bean man.</p>
                    <p>Tyler Lane is awesome, cool, and our incredible hardware guy. The rest of us would prefer not to touch hardware with a ten-foot pole, but he gets out there and soldiers our parts and generally makes the wires work. This project wouldn't be possible without him.</p>
                </div>
            </div>
        </div>);
}

export default About;