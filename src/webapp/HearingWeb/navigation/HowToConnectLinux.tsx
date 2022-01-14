import { useNavigate } from "react-router";
import { Header } from "../components/Header";
import "../styles.css"
import { colors } from "../colors.js"

declare var require: any
var React = require('react');
var ReactDOM = require('react-dom');


function HowToConnectLinux() {
    const navigate = useNavigate();
    return (
        <div className="pageBackground" style={{ backgroundColor: colors.headertab1}}>
            <Header style={{ width: "100%" }} />
            <div className="pageHeader">Linux</div>
            <div>
                <button onClick={() => navigate('/howtoconnect', { replace: true })}>Back</button>
                </div>
            <div className="pagePanel">
                hello
                hello
                hello
                hello
                helloLorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla vitae lorem non odio euismod tincidunt. Mauris varius pellentesque tellus mattis auctor. In nec orci quis ipsum pulvinar rutrum in id tortor. Ut commodo tincidunt justo et vehicula. Mauris eget tortor sit amet turpis varius semper auctor a quam. Proin vitae ultricies ante, nec fermentum elit. Sed pretium a est non suscipit. Nullam gravida risus a tellus malesuada, vel luctus elit vestibulum. Cras ut sapien enim. Donec euismod cursus pellentesque. Quisque maximus facilisis euismod. Sed neque ex, dignissim non sem vitae, feugiat volutpat lorem. Morbi consequat arcu scelerisque quam consectetur vulputate. Maecenas suscipit vestibulum ante, eget auctor nisi. Etiam non mauris a turpis facilisis pellentesque.

                Nunc luctus turpis risus, id accumsan lectus condimentum id. Nam dapibus vehicula diam, in venenatis leo tristique ac. Cras pharetra congue gravida. Ut nec facilisis ex, sollicitudin sodales sem. Quisque commodo hendrerit nisi, sit amet mollis nulla porta vel. Quisque imperdiet massa vel eleifend egestas. In scelerisque mattis pharetra. Ut in ipsum at tortor blandit rhoncus. Sed sit amet odio ultricies, dignissim erat a, aliquet nulla. Vivamus nec velit lacus. Nam a erat vitae lectus lobortis condimentum. Donec sed nulla eget quam consectetur cursus at et turpis. Vivamus nec est id nisl iaculis fermentum. Donec rhoncus lacinia enim et luctus.

                Vestibulum iaculis lorem non ligula vulputate, quis vulputate ligula luctus. Phasellus est tortor, aliquet quis molestie fringilla, iaculis vel dui. Donec at leo lorem. Sed cursus interdum eros sed semper. Suspendisse rhoncus aliquam ligula, eget dictum lectus. In facilisis sed mauris non pellentesque. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aliquam placerat ex leo, non lobortis nisl mattis in. Cras euismod magna sapien, in dictum nisl ornare et.

                Mauris a consectetur diam. Praesent bibendum viverra commodo. Nam ullamcorper felis ante, a bibendum libero ornare et. Nunc sed felis vel sapien aliquam elementum. Mauris ullamcorper purus id ullamcorper euismod. Quisque tempor elementum rhoncus. Nullam id sodales tellus. In fermentum, justo eu malesuada posuere, arcu enim venenatis justo, sit amet finibus risus erat laoreet ex. Mauris sollicitudin lectus arcu, iaculis imperdiet velit sollicitudin a. Mauris sed auctor dolor, in placerat lorem. Curabitur ante lectus, dignissim eget auctor nec, fringilla quis odio. Nulla eu odio vehicula, euismod ante eget, sollicitudin ex.

                Suspendisse potenti. Praesent et fringilla ligula. Etiam dui justo, rutrum fringilla dui ut, suscipit commodo urna. Duis ac neque eu velit tincidunt sollicitudin id vitae nibh. Sed eu sagittis dolor. Vivamus dapibus posuere convallis. Aliquam dignissim, nunc at sollicitudin vestibulum, erat quam semper ex, sed dictum lacus nibh sed erat. Morbi et accumsan metus. Nunc eros erat, maximus dignissim iaculis vitae, iaculis ut ligula. Suspendisse nec lectus tristique, euismod neque id, ultrices urna. Fusce nec orci commodo nunc iaculis volutpat. Pellentesque vel condimentum risus, volutpat tincidunt urna. Duis quis lectus id enim lacinia pulvinar. Sed ultricies semper lectus accumsan cursus. Ut ut eros in lectus bibendum congue. Nam et arcu pulvinar, ornare odio convallis, semper sapien.
                this is dummy text

            </div>
        </div>
    );
}
export default HowToConnectLinux;
