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
                <div className="pageHeader">About the Bracelet</div>
                <div className="bodyText">
                    <p>Compatible with any Bluetooth-enabled device.</p>
                    <p>Customizable bands with a myriad of color selections.</p>
                    <table style={{ margin: "auto", width:"40%"}}>
                        <tr>
                            <td>
                                <div className="bands" style={{ backgroundColor: colors.band1 }} />
                            </td>
                            <td>
                                <div className="bands" style={{ backgroundColor: colors.band2 }} />
                            </td>
                            <td>
                                <div className="bands" style={{ backgroundColor: colors.band3 }} />
                            </td>
                            <td>
                                <div className="bands" style={{ backgroundColor: colors.band4 }} />
                            </td>
                            <td>
                                <div className="bands" style={{ backgroundColor: colors.band5 }} />
                            </td>
                            <td>
                                <div className="bands" style={{ backgroundColor: colors.band6 }} />
                            </td>
                        </tr>
                    </table>
                    <p>Specs: blah blah blah placeholder add this later</p>
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