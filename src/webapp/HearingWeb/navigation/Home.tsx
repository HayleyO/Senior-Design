import { Header } from "../components/Header";
import "../styles.css"

declare var require: any
var React = require('react');

function Home() {
    return (
        <Header style={{ width: "100%" }} />
    );
}

export default Home;